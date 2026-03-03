import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/features/auth/domain/entities/user_entity.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmail implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;
  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
