abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}

class SignOutRequested extends AuthEvent {

  SignOutRequested();
}

class CheckAuthStatusRequested extends AuthEvent {}

class SignInWithGoogleRequested extends AuthEvent {
  SignInWithGoogleRequested();
}
class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({required this.email});
}

class AuthenticateWithBiometricRequested extends AuthEvent{
  final String reason;
  AuthenticateWithBiometricRequested({required this.reason});
}
class AuthStatusReset extends AuthEvent {}


class CheckBiometricRequiredRequested extends AuthEvent {
}

/// Turn off biometric re-lock and return to the app (e.g. simulator without Face ID).
class BiometricDisableGateRequested extends AuthEvent {}

