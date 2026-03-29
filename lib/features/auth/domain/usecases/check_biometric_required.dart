import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/services/app_lifecycle_manager.dart';
import 'package:routiner/core/services/biometric_service.dart';
import 'package:routiner/core/usecases/usecase.dart';

class CheckBiometricRequiredUseCase implements UseCase<bool, NoParams> {
  final BiometricService biometricService;
  final AppLifecycleManager appLifecycleManager;

  CheckBiometricRequiredUseCase({
    required this.biometricService,
    required this.appLifecycleManager,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      debugPrint('[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase: start');
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        debugPrint('[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase: no user → false');
        return const Right(false);
      }
      final isBiometricEnabled = await biometricService.getBiometricPreference();
      if (!isBiometricEnabled) {
        debugPrint(
          '[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase: preference disabled '
          '(need biometric_enabled=true in secure storage)',
        );
        return const Right(false);
      }
      debugPrint('[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase: preference enabled');
      final threshold = kDebugMode
          ? const Duration(seconds: 5)
          : const Duration(minutes: 5);
      final shouldRequireReauth =
          appLifecycleManager.shouldRequireReauth(threshold: threshold);
      debugPrint(
        '[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase: shouldRequireReauth=$shouldRequireReauth '
        '(threshold ${threshold.inSeconds}s, kDebugMode=$kDebugMode)',
      );
      return Right(shouldRequireReauth);
    } catch (e) {
      debugPrint('[BIOMETRIC_DEBUG] CheckBiometricRequiredUseCase error: $e');
      return Left(
        BiometricFailure('An error occurred while checking biometric required'),
      );
    }
  }
}