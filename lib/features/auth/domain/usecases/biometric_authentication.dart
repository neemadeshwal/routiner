import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/services/biometric_service.dart';
import 'package:routiner/core/usecases/usecase.dart';

class BiometricAuthenticationUseCase
    implements UseCase<bool, BiometricAuthenticationParams> {
  final BiometricService biometricService;

  BiometricAuthenticationUseCase(this.biometricService);

  @override
  Future<Either<Failure, bool>> call(BiometricAuthenticationParams params) async {
    try {
      debugPrint('[BIOMETRIC_DEBUG] BiometricAuthenticationUseCase: authenticate()');
      final (ok, errorMessage) = await biometricService.authenticate(
        localizedReason: params.reason,
      );
      if (ok) {
        return const Right(true);
      }
      return Left(
        BiometricFailure(errorMessage ?? 'Authentication failed'),
      );
    } catch (e) {
      return Left(
        BiometricFailure('An error occurred while authenticating with biometric'),
      );
    }
  }
}

class BiometricAuthenticationParams extends Equatable {
  final String reason;

  const BiometricAuthenticationParams({required this.reason});

  @override
  List<Object?> get props => [reason];
}