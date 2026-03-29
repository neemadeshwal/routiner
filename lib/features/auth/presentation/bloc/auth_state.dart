abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  // final UserEntity user;

  // AuthAuthenticated({required this.user});
}


class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class ForgotPasswordSuccess extends AuthState {}

class BiometricAuthenticationRequired extends AuthState{
  
}
class BiometricAuthenticationSuccess extends AuthState{}

class BiometricAuthenticationFailed extends AuthState{
  final String message;
  BiometricAuthenticationFailed(this.message);
}
