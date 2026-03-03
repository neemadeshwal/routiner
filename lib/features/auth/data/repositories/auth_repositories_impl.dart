import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:routiner/features/auth/domain/entities/user_entity.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoriesImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoriesImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.signInWithEmail(email, password);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure('An unexpected error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final user = await remoteDatasource.signUpWithEmail(
        email,
        password,
        userName,
      );
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("An unexpected error occured"));
    }
  }
}
