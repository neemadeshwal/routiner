import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // Email/ password auth

  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String userName,
  });

  Future<Either<Failure,void>> signOut();
  Future<Either<Failure, void>> forgotPassword(String email);

  // Future<Either<Failure, void>> sendEmailVerification();

  // Future<Either<Failure, void>> resetPassword(String email);

  // Google Sign in
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  // Facebook Sign in
  // Future<Either<Failure, UserEntity>> signInWithFacebook();

  // Future<Either<Failure, UserEntity>> verifyOtp({
  //   required String verificationId,
  //   required String otp,
  // });

  // Biometric Auth

  // Future<Either<Failure, bool>> isBiometricAvailable();

  // Future<Either<Failure, bool>> authenticateWithBiometric();

  // Future<Either<Failure, void>> enableBiometric(bool enable);

  // User management
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
