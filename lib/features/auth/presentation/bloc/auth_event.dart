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

class SignOutRequested extends AuthEvent {}

class CheckAuthStatusRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({required this.email});
}

class AuthStatusReset extends AuthEvent {}
