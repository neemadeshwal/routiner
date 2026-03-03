import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Auth failure

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class InavalidCredentialsFailure extends Failure {
  const InavalidCredentialsFailure(super.message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(super.message);
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure(super.message);
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure(super.message);
}

class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure(super.message);
}

class BiometricFailure extends Failure {
  const BiometricFailure(super.message);
}
