import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/entities/user_entity.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmail implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmail(
      email: params.email,
      password: params.password,
      userName: params.userName,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String userName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object> get props => [email, password, userName];
}
