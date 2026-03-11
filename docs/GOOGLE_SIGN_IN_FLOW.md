# Google Sign-In Flow — Complete Walkthrough

This document traces the **entire** Google Sign-In flow in your app, from app startup to the final UI update, with file and layer references.

---

## Part 0: App Startup (Before Any Tap)

### 0.1 `main.dart` — Bootstrap

```text
main() runs
  → WidgetsFlutterBinding.ensureInitialized()
  → Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  → GoogleSignIn.instance.initialize()   // Required once before any Google Sign-In use
  → di.init()                            // Registers all dependencies in GetIt
  → runApp(BlocProvider<AuthBloc>(...))
```

**Why `GoogleSignIn.instance.initialize()`?**  
The `google_sign_in` 7.x package uses a **singleton** (`GoogleSignIn.instance`). You must call `initialize()` exactly once and await it before calling `authenticate()` or anything else. That wires the SDK to the platform (Android/iOS) and loads config (e.g. from `GoogleService-Info.plist` / `google-services.json`).

---

### 0.2 `injection_container.dart` — Dependency Graph

GetIt builds this dependency graph (simplified for Google flow):

```text
AuthBloc
  ← signInWithGoogleUseCase: SignInWithGoogle(sl())

SignInWithGoogle (use case)
  ← repository: AuthRepository (→ AuthRepositoriesImpl)

AuthRepositoriesImpl
  ← remoteDatasource: AuthRemoteDatasource (→ AuthRemoteDataSourceImpl)

AuthRemoteDataSourceImpl
  ← firebaseAuth: FirebaseAuth.instance
  ← firestore: FirebaseFirestore.instance
  ← googleSignIn: GoogleSignIn.instance
```

So when the UI eventually calls the use case, the **same** `GoogleSignIn.instance` and `FirebaseAuth.instance` used at startup are the ones used for sign-in. No new instances are created for the button tap.

---

## Part 1: User Taps "Continue with Google"

### 1.1 UI — Button Tap

**File:** `lib/features/auth/presentation/pages/signin_screen.dart` (or `signup_screen.dart`)

The "Continue with Google" `SocialButton` has:

```dart
onPressed: loading
    ? () {}
    : () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
```

So when the user taps and `loading` is false:

1. `context.read<AuthBloc>()` gets the `AuthBloc` provided by `BlocProvider` in `main.dart`.
2. `.add(SignInWithGoogleRequested())` pushes an **event** into the bloc.  
   Event is defined in `auth_event.dart`: `class SignInWithGoogleRequested extends AuthEvent { SignInWithGoogleRequested(); }`.

The bloc receives the event and runs the handler registered for that type.

---

## Part 2: Bloc Handles the Event

### 2.1 Event → Handler Mapping

**File:** `lib/features/auth/presentation/bloc/auth_bloc.dart`

In the constructor:

```dart
on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
```

So when the event is `SignInWithGoogleRequested`, the bloc calls:

`_onSignInWithGoogleRequested(SignInWithGoogleRequested event, Emitter<AuthState> emit)`.

---

### 2.2 Handler Logic (Bloc)

**File:** `lib/features/auth/presentation/bloc/auth_bloc.dart` (lines 88–98)

```dart
Future<void> _onSignInWithGoogleRequested(
  SignInWithGoogleRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());                                    // ①
  final result = await signInWithGoogleUseCase(const google_usecase.NoParams());  // ②
  result.fold(
    (failure) => emit(AuthError(failure.message)),          // ③a
    (user) => emit(Authenticated()),                        // ③b
  );
}
```

Step by step:

- **①** `emit(AuthLoading())`  
  Bloc emits `AuthLoading`. The screen’s `builder` sees `state is AuthLoading`, so `loading == true` and the Google button’s `onPressed` becomes a no-op (prevents double-tap). Any loading UI you have will show.

- **②** `signInWithGoogleUseCase(const google_usecase.NoParams())`  
  The bloc does **not** talk to Firebase or Google directly. It only calls the **use case**.  
  The use case is injected as `signInWithGoogleUseCase` (type `SignInWithGoogle` from `sign_in_with_google.dart`).  
  It returns `Future<Either<Failure, UserEntity>>`: either a failure (left) or a user (right).

- **③** `result.fold(...)`  
  - **Left (failure):** `emit(AuthError(failure.message))`.  
  - **Right (user):** `emit(Authenticated())`.  
  The bloc never holds the user entity in state; it only emits success vs error. Navigation and snackbars are driven by these states in the UI.

So the flow is: **Event → emit Loading → call use case → fold result → emit Authenticated or AuthError**.

---

## Part 3: Use Case — Single Responsibility

### 3.1 SignInWithGoogle Use Case

**File:** `lib/features/auth/domain/usecases/sign_in_with_google.dart`

```dart
class SignInWithGoogle implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
```

- The use case’s only job is to call **one** method on the **abstract** `AuthRepository`: `signInWithGoogle()`.
- It doesn’t know about Firebase, Google SDK, or HTTP. It only knows “repository can sign in with Google and return either failure or user.”
- `NoParams` is used because Google sign-in doesn’t need email/password from the form; the SDK handles account selection.
- Return type is `Either<Failure, UserEntity>`: domain-friendly result that the bloc then maps to states.

So: **Use case = single call to repository, returns Either**.

---

## Part 4: Repository — Map Exceptions to Either

### 4.1 AuthRepositoriesImpl

**File:** `lib/features/auth/data/repositories/auth_repositories_impl.dart` (lines 53–62)

```dart
@override
Future<Either<Failure, UserEntity>> signInWithGoogle() async {
  try {
    final user = await remoteDatasource.signInWithGoogle();
    return Right(user);   // UserModel is a UserEntity
  } catch (e) {
    return Left(AuthFailure("An unexpected error occured"));
  }
}
```

- The **data** layer (repository impl) talks to the **datasource** (which will talk to Google + Firebase).
- It converts:
  - **Success:** `UserModel` from the datasource → returned as `Right(user)` (domain sees it as `UserEntity` because `UserModel extends UserEntity`).
  - **Any exception:** caught and turned into `Left(AuthFailure(...))`.

So: **Repository = call datasource, wrap in Either**.

---

## Part 5: Datasource — Where Google & Firebase Live

### 5.1 AuthRemoteDataSourceImpl.signInWithGoogle()

**File:** `lib/features/auth/data/datasources/auth_remote_datasource.dart` (lines 86–100)

This is the **only** place in your app that touches the Google Sign-In SDK and Firebase Auth for this flow.

```dart
@override
Future<UserModel> signInWithGoogle() async {
  try {
    // --- Step A: Google SDK (user picks account, we get tokens) ---
    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) throw AuthException("Sign in failed");

    // --- Step B: Firebase Auth (exchange token for Firebase user) ---
    final userCreds = await firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: idToken),
    );
    if (userCreds.user == null) throw AuthException("Sign in failed");

    // --- Step C: Your app model ---
    return UserModel.fromFirebaseUser(userCreds.user!);
  } catch (e) {
    throw AuthException("An unexpected error occured.");
  }
}
```

#### Step A — `googleSignIn.authenticate()`

- `googleSignIn` is `GoogleSignIn.instance` (same instance initialized in `main()`).
- `authenticate()` (google_sign_in 7.x):
  - Shows the system Google account picker (or uses the current account).
  - User selects an account and may see consent screens.
  - On success, returns a `GoogleSignInAccount` with identity and tokens.
  - On cancel/failure, throws `GoogleSignInException`.
- `googleUser.authentication` is a getter that gives a `GoogleSignInAuthentication` object.
- In 7.x that object has `idToken` (and possibly other tokens depending on platform). You only need `idToken` for Firebase.

So after Step A you have a **Google ID token** that proves the user signed in with Google.

#### Step B — `firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(...))`

- Firebase Auth does **not** talk to Google’s UI. It only trusts **credentials**.
- `GoogleAuthProvider.credential(idToken: idToken)` builds a credential that says: “this sign-in is for the user identified by this Google ID token.”
- `signInWithCredential`:
  - Sends the token to Firebase’s servers.
  - Firebase validates the token with Google, then creates or signs in a Firebase user.
  - Returns `UserCredential` with `user` (Firebase `User`).

So after Step B you have a **Firebase User** (same as with email/password or other providers).

#### Step C — `UserModel.fromFirebaseUser(userCreds.user!)`

- Your app doesn’t use Firebase’s `User` type in the domain. You map it to your own model.
- `UserModel.fromFirebaseUser` (in `user_model.dart`) builds a `UserModel` (extends `UserEntity`) from `User`: uid, email, displayName, photoURL, etc.
- That `UserModel` is returned to the repository, which already wrapped it in `Right(user)` for the use case and bloc.

So: **Datasource = Google UI + tokens → Firebase credential → Firebase User → UserModel**.

---

## Part 6: Data Flowing Back Up

The return path is the reverse of the call stack:

1. **Datasource** returns `UserModel` (or throws → repository catches).
2. **Repository** returns `Right(UserModel)` or `Left(AuthFailure(...))`.
3. **Use case** returns that `Either` unchanged.
4. **Bloc** does `result.fold(emit AuthError, emit Authenticated)`.

So:

- **Success path:** `UserModel` → `Right(user)` → bloc emits `Authenticated()`.
- **Error path:** exception → `Left(AuthFailure(...))` → bloc emits `AuthError(failure.message)`.

---

## Part 7: UI Reacts to New State

### 7.1 BlocConsumer

**File:** `lib/features/auth/presentation/pages/signin_screen.dart` (same pattern on signup)

```dart
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      context.go(RouteConstants.home);
    }
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message), backgroundColor: Colors.red),
      );
    }
  },
  builder: (context, state) {
    final loading = state is AuthLoading;
    // ... buttons use loading to disable or show loading UI
  },
)
```

- **listener** runs when the state **changes** (and is not build):
  - `Authenticated` → `context.go(RouteConstants.home)` (navigate to home).
  - `AuthError` → show red SnackBar with `state.message`.
- **builder** runs when state changes: `loading` is true while `state is AuthLoading`, so the Google button uses `onPressed: () {}` during loading.

So: **Authenticated → go to home; AuthError → snackbar; AuthLoading → loading behavior in builder**.

---

## End-to-End Flow Diagram (Summary)

```text
[User taps "Continue with Google"]
         │
         ▼
[SigninScreen]  context.read<AuthBloc>().add(SignInWithGoogleRequested())
         │
         ▼
[AuthBloc]  on<SignInWithGoogleRequested> → _onSignInWithGoogleRequested
         │  emit(AuthLoading())
         │  signInWithGoogleUseCase(NoParams())
         ▼
[SignInWithGoogle]  repository.signInWithGoogle()
         │
         ▼
[AuthRepositoriesImpl]  try { remoteDatasource.signInWithGoogle() } → Right(user) | Left(AuthFailure)
         │
         ▼
[AuthRemoteDataSourceImpl]
         │  googleSignIn.authenticate()     → Google account picker, then idToken
         │  firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(idToken))  → Firebase User
         │  UserModel.fromFirebaseUser(user)  → return UserModel
         ▼
[Back up the stack: UserModel → Right → bloc]
         │
         ▼
[AuthBloc]  result.fold(emit AuthError, emit Authenticated)
         │
         ▼
[BlocConsumer listener]
         │  Authenticated → context.go(home)
         │  AuthError → SnackBar(state.message)
         ▼
[User sees home screen or error message]
```

---

## Summary Table

| Layer        | File / class                     | Responsibility |
|-------------|-----------------------------------|----------------|
| UI          | `signin_screen.dart` / signup     | Dispatch `SignInWithGoogleRequested`, react to state (navigate, snackbar, loading). |
| Presentation| `AuthBloc`                        | Emit loading → call use case → fold to Authenticated / AuthError. |
| Domain      | `SignInWithGoogle` use case       | Call `repository.signInWithGoogle()`, return `Either<Failure, UserEntity>`. |
| Domain      | `AuthRepository` (interface)     | Contract: `signInWithGoogle()` returns `Either<Failure, UserEntity>`. |
| Data        | `AuthRepositoriesImpl`            | Call datasource, wrap in `Right(user)` or `Left(AuthFailure)`. |
| Data        | `AuthRemoteDataSourceImpl`        | `GoogleSignIn.authenticate()` → idToken → `FirebaseAuth.signInWithCredential` → `UserModel`. |
| External    | Google Sign-In SDK                | Account picker, consent, idToken. |
| External    | Firebase Auth                     | Validate idToken, create/return Firebase User. |

That’s the complete Google Sign-In flow in your app, in as much detail as possible from UI down to Google/Firebase and back to the UI.
