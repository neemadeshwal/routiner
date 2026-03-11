import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/exception.dart';
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
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
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
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }
  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDatasource.getCurrentUser();
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await remoteDatasource.signInWithGoogle();
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDatasource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDatasource.forgotPassword(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }
}
