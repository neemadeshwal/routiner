# Sign Up Flow — End-to-End

This document describes the flow from the moment the user taps **Sign Up** until the app either navigates to the home screen or shows an error.

---

## 1. Overview

**UI (SignUpScreen)** → **BLoC event (SignUpRequested)** → **BLoC handler (_onSignUpRequested)** → **Use case (SignUpWithEmail)** → **Repository (AuthRepository)** → **Repository impl (AuthRepositoriesImpl)** → **Remote datasource (AuthRemoteDataSourceImpl)** → **Firebase Auth** → **Result bubbles back** → **BLoC emits new state** → **UI reacts** (navigate or show error).

---

## 2. User Taps "Sign Up" (UI Layer)

**File:** `lib/features/auth/presentation/pages/signup_screen.dart`

- The user fills in name, email, password and checks the "I have read Privacy Policy" checkbox.
- On tap, `_handleSignup()` runs:
  - Reads values from `_nameController`, `_emailController`, `_passwordController`.
  - Runs `_formKey.currentState!.validate()` (validators: username, email, strongPassword).
  - Checks `_isChecked` (terms accepted).
- If validation passes, the screen dispatches an event into `AuthBloc`:

```dart
context.read<AuthBloc>().add(
  SignUpRequested(email: email, password: password, name: name),
);
```

---

## 3. Event Definition

**File:** `lib/features/auth/presentation/bloc/auth_event.dart`

`SignUpRequested` is an event carrying:

- `email` (String)
- `password` (String)
- `name` (String)

It extends `AuthEvent`, so the BLoC can route it to the sign-up handler.

---

## 4. BLoC Receives the Event

**File:** `lib/features/auth/presentation/bloc/auth_bloc.dart`

The constructor registers:

```dart
on<SignUpRequested>(_onSignUpRequested);
```

So when the UI adds `SignUpRequested`, the BLoC calls `_onSignUpRequested(event, emit)`.

---

## 5. BLoC Handler: _onSignUpRequested

**File:** `lib/features/auth/presentation/bloc/auth_bloc.dart`

1. **Emit loading:** `emit(AuthLoading());` so the UI can show loading (e.g. disable button, spinner).
2. **Call use case:**  
   `signUpUseCase(SignUpParams(email: event.email, password: event.password, userName: event.name))`  
   Returns `Either<Failure, UserEntity>`.
3. **Handle result with `fold`:**
   - **Left (failure):** `emit(AuthError(failure.message))`
   - **Right (success):** `emit(Authenticated())`

The BLoC never talks to Firebase directly; it only calls the use case and maps the `Either` to states.

---

## 6. Sign Up Use Case (Domain Layer)

**File:** `lib/features/auth/domain/usecases/sign_up_with_email.dart`

- **Input:** `SignUpParams` (email, password, userName).
- **Output:** `Future<Either<Failure, UserEntity>>`.
- **Behavior:** Calls `repository.signUpWithEmail(email: params.email, password: params.password, userName: params.userName)` and returns the repository's result.

The use case depends only on the abstract `AuthRepository` (domain contract).

---

## 7. Repository (Domain Contract → Data Implementation)

**Interface:** `lib/features/auth/domain/repositories/auth_repository.dart`

```dart
Future<Either<Failure, UserEntity>> signUpWithEmail({
  required String email,
  required String password,
  required String userName,
});
```

**Implementation:** `lib/features/auth/data/repositories/auth_repositories_impl.dart`

- Calls `remoteDatasource.signUpWithEmail(email, password, userName)`.
- On success: returns `Right(user)` (user is a `UserEntity`/model).
- On exception: returns `Left(AuthFailure("An unexpected error occured"))`.

All sign-up errors are currently mapped to that generic message.

---

## 8. Remote Datasource → Firebase

**File:** `lib/features/auth/data/datasources/auth_remote_datasource.dart`

1. Calls `firebaseAuth.createUserWithEmailAndPassword(email, password)`.
2. If `userCreds.user == null`, throws `AuthException("Sign up failed")`.
3. Otherwise returns `UserModel.fromFirebaseUser(userCreds.user!)`.
4. Any other exception is rethrown as `AuthException("An Unexpected error occured.")`.

This is the only place that talks to Firebase Auth for sign up. The `userName` is accepted in the API but not yet sent to Firebase (e.g. display name or Firestore would be set elsewhere if needed).

---

## 9. Dependency Injection

**File:** `lib/injection_container.dart`

Wiring:

- **AuthBloc** (factory) gets `signUpUseCase: sl()` → `SignUpWithEmail`.
- **SignUpWithEmail** gets `repository: sl()` → `AuthRepositoriesImpl`.
- **AuthRepositoriesImpl** gets `remoteDatasource: sl()` → `AuthRemoteDataSourceImpl`.
- **AuthRemoteDataSourceImpl** gets `firebaseAuth: sl()` and `firestore: sl()` (e.g. `FirebaseAuth.instance`, `FirebaseFirestore.instance`).

So the runtime chain is: **Bloc → UseCase → AuthRepository (impl) → AuthRemoteDataSourceImpl → FirebaseAuth**.

---

## 10. UI Reaction to States

**File:** `lib/features/auth/presentation/pages/signup_screen.dart`

The screen uses `BlocConsumer<AuthBloc, AuthState>`:

- **listener:**
  - `state is Authenticated` → `context.go(RouteConstants.home)` (navigate to home).
  - `state is AuthError` → show red `SnackBar` with `state.message`.
- **builder:**  
  `final loading = state is AuthLoading;` — used to show loading UI and disable the button.

So after sign up:

- **Success:** BLoC emits `Authenticated()` → listener navigates to home.
- **Failure:** BLoC emits `AuthError(message)` → listener shows snack bar.
- **In progress:** `AuthLoading` → builder shows loading state.

---

## 11. End-to-End Timeline (Summary)

1. User fills form, checks terms, taps **Sign Up**.
2. Form validates; screen dispatches `SignUpRequested(email, password, name)`.
3. BLoC emits `AuthLoading`.
4. BLoC calls `SignUpWithEmail(SignUpParams(...))`.
5. Use case calls `AuthRepository.signUpWithEmail(...)`.
6. `AuthRepositoriesImpl` calls `AuthRemoteDatasource.signUpWithEmail(...)`.
7. `AuthRemoteDataSourceImpl` calls `FirebaseAuth.createUserWithEmailAndPassword(...)` and maps result to `UserModel`.
8. Result flows back: Repository returns `Right(user)` or `Left(AuthFailure(...))`.
9. BLoC emits `Authenticated()` or `AuthError(message)`.
10. UI: on `Authenticated` → go to home; on `AuthError` → show snack bar; during `AuthLoading` → show loading state.
