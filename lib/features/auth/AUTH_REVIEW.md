# Auth Feature – Review & Improvement Guide

## What’s working well

- **Clean architecture**: Clear separation of domain (entities, repository, use cases), data (datasources, models, repo impl), and presentation (bloc, pages, widgets).
- **BLoC**: Single `AuthBloc` with events/states; `BlocConsumer` used for navigation and snackbars.
- **Dependency injection**: GetIt in `injection_container.dart`; factory for bloc, singletons for use cases and data.
- **Error handling**: `Either<Failure, T>` from domain down; `AuthException` in datasource for Firebase errors; `ForgotPasswordSuccess` state so forgot-password doesn’t log the user in.
- **Reusable UI**: Shared widgets (`Background`, `PasswordToggle`, `SocialButton`), custom inputs/buttons, validators.

---

## Issues & improvements

### 1. **Duplicate `NoParams`**

- **Where**: `GetCurrentUser` and `SignInWithGoogle` each define their own `NoParams`.
- **Why it matters**: Duplication and risk of confusion when both are used (e.g. `google_usecase.NoParams` in bloc).
- **Fix**: Define `NoParams` once (e.g. in `core/usecases/` or in `get_current_user.dart`) and reuse it everywhere. Remove the duplicate from `sign_in_with_google.dart` and import the shared one.

### 2. **Repository swallows real errors**

- **Where**: In `auth_repositories_impl.dart`, `signInWithEmail`, `signUpWithEmail`, `getCurrentUser`, `signInWithGoogle`, and `signOut` use a generic `AuthFailure('An unexpected error...')` instead of the exception message.
- **Why it matters**: Users and developers don’t see Firebase messages (e.g. “wrong password”, “user not found”, “too many requests”).
- **Fix**: Catch `AuthException` and use `AuthFailure(e.message)` for those methods too (like you already do for `forgotPassword`).

### 3. **Datasource: generic catch hides Firebase errors**

- **Where**: In `auth_remote_datasource.dart`, `signInWithEmail`, `signUpWithEmail`, `getCurrentUser`, `signOut`, and `signInWithGoogle` use a single `catch (e)` and throw a generic `AuthException`.
- **Why it matters**: Firebase’s specific error messages are lost.
- **Fix**: Use `on FirebaseAuthException catch (e)` and throw `AuthException(e.message ?? '...')` in each method, then a generic `catch` for the rest.

### 4. **Sign up: display name never saved**

- **Where**: `AuthRemoteDataSourceImpl.signUpWithEmail` receives `userName` but only calls `createUserWithEmailAndPassword`; it never sets `displayName` on the user.
- **Why it matters**: The name the user entered at sign up doesn’t appear in Firebase Auth (or in your app if you read `displayName`).
- **Fix**: After `createUserWithEmailAndPassword`, call `userCreds.user!.updateDisplayName(userName)` (and optionally `userCreds.user!.reload()` then return the refreshed user).

### 5. **Sign up screen: back button triggers sign up**

- **Where**: Sign up screen back button: `onPressed: loading ? null : _handleSignup`.
- **Why it matters**: Back button submits the form instead of going back.
- **Fix**: Use `onPressed: () => context.pop()` or `context.go(RouteConstants.signin)` (and don’t tie it to `_handleSignup`).

### 6. **Forgot password success: navigate back to sign in**

- **Where**: In `forgot_password.dart` listener, `context.go(RouteConstants.signin)` after `ForgotPasswordSuccess` is commented out.
- **Why it matters**: After “check your email” the user stays on the same screen.
- **Fix**: Uncomment `context.go(RouteConstants.signin)` so they’re sent back to sign in after success.

### 7. **Remove debug `print` statements**

- **Where**: e.g. `signin_screen.dart` (“Email / Password”), `forgot_password.dart` (“Email: …”).
- **Why it matters**: Logs sensitive data and clutter in production.
- **Fix**: Remove them or replace with proper logging (e.g. `debugPrint` in debug only) and never log passwords.

### 8. **Unused / dead code**

- `**auth_local_datasources.dart`**: Empty. Either implement a local auth cache (e.g. store “last user” or tokens) or remove the file and any references.
- `**AuthStatusReset**`: Event is defined but not handled in the bloc. Use it (e.g. to clear `AuthError` / reset to `AuthInitial`) or remove it.
- `**reset_password.dart**`: Form submit only prints; no call to Firebase or bloc. Either wire it to Firebase (e.g. confirm password reset from link) or leave as placeholder and document it.
- `**otp_verification.dart**`: Hardcoded pin `'222222'` and no real verification. Matches “OTP will be backend later” – keep as UI-only placeholder or remove until you implement real OTP.

### 9. **Small consistency / quality**

- **Sign in screen**: Back button `onPressed: () {}` does nothing. Prefer `context.pop()` or `context.go(...)` so back has consistent behavior.
- `**SignOutRequested()`**: Can be `const` for consistency with other events.
- `**Authenticated` state**: Holds no user data (commented). If you need the current user on the home screen, add e.g. `final UserEntity? user` to `Authenticated` and set it from the bloc when emitting.
- **Reset password screen**: `TextEditingController`s are never disposed in `dispose()`. Add `dispose()` and dispose both controllers.

### 10. **Firestore in remote datasource**

- **Where**: `AuthRemoteDataSourceImpl` takes and stores `FirebaseFirestore firestore` but never uses it.
- **Why it matters**: Unused dependency and confusion.
- **Fix**: Use it (e.g. to store user profile or preferences) or remove the parameter and its registration in GetIt.

---

## Suggested order of work

1. **Quick wins**: Fix sign up back button, uncomment forgot-password navigation, remove `print`s, add `dispose` in reset password.
2. **Errors**: Use `FirebaseAuthException` in the remote datasource and pass `AuthException.message` through the repository for all auth methods.
3. **Data**: Save display name on sign up; optionally add user to `Authenticated` if needed by the app.
4. **Structure**: Single `NoParams`; handle or remove `AuthStatusReset`; decide on local datasource and Firestore (use or remove).

---

## Security reminder

- Never log or send passwords.
- Ensure password reset and OTP (when you add it) are handled server-side or via Firebase; don’t validate sensitive tokens only in the app.

