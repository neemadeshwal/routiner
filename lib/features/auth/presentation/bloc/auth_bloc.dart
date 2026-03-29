import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:routiner/core/services/app_lifecycle_manager.dart';
import 'package:routiner/core/services/biometric_service.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/usecases/biometric_authentication.dart';
import 'package:routiner/features/auth/domain/usecases/check_biometric_required.dart';
import 'package:routiner/features/auth/domain/usecases/forgot_password.dart';
import 'package:routiner/features/auth/domain/usecases/get_current_user.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_out.dart';
import 'package:routiner/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_google.dart' as google_usecase;
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInUseCase;
  final SignUpWithEmail signUpUseCase;
  final SignOut signOutUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final google_usecase.SignInWithGoogle signInWithGoogleUseCase;
  final ForgotPassword forgotPasswordUseCase;
  final BiometricAuthenticationUseCase biometricAuthenticationUseCase;
  final CheckBiometricRequiredUseCase checkBiometricRequiredUseCase;

  final AppLifecycleManager appLifecycleManager;
  final BiometricService biometricService;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
    required this.signInWithGoogleUseCase,
    required this.forgotPasswordUseCase,
    required this.biometricAuthenticationUseCase,
    required this.checkBiometricRequiredUseCase,
    required this.appLifecycleManager,
    required this.biometricService,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<CheckBiometricRequiredRequested>(_onCheckBiometricRequired);
    on<AuthenticateWithBiometricRequested>(_onAuthenticateWithBiometric);
    on<BiometricDisableGateRequested>(_onBiometricDisableGate);


    appLifecycleManager.onAppResumed = () {
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc: onAppResumed → CheckBiometricRequiredRequested');
      add(CheckBiometricRequiredRequested());
    };
    appLifecycleManager.init();
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getCurrentUserUseCase(const NoParams());

    await result.fold(
      (failure) async {
        emit(Unauthenticated());
      },
      (user) async {
        if (user != null) {
          await _persistBiometricOptInIfAvailable();
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    // 1. Emit loading
    emit(AuthLoading());
    // 2. Call use cases
    final result = await signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );

    //3. Handle result

    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (user) async {
        await _persistBiometricOptInIfAvailable();
        emit(Authenticated());
      },
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        userName: event.name,
      ),
    );

    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (user) async {
        await _persistBiometricOptInIfAvailable();
        emit(Authenticated());
      },
    );
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signOutUseCase(NoParams());
    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (_) async {
        await biometricService.clearBiometricData();
        emit(Unauthenticated());
      },
    );
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signInWithGoogleUseCase(const google_usecase.NoParams());
    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (user) async {
        await _persistBiometricOptInIfAvailable();
        emit(Authenticated());
      },
    );
  }

  Future<void> _persistBiometricOptInIfAvailable() async {
    try {
      final available = await biometricService.isBiometricAvailable();
      if (!available) {
        debugPrint(
          '[BIOMETRIC_DEBUG] Biometric opt-in skipped (device reports no biometrics)',
        );
        return;
      }
      await biometricService.saveBiometricPreference(true);
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await biometricService.saveUserIdForBiometric(uid);
      }
      print('[BIOMETRIC_DEBUG] Biometric opt-in saved after successful sign-in');
    } catch (e) {
      debugPrint('[BIOMETRIC_DEBUG] _persistBiometricOptInIfAvailable: $e');
    }
  }

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event,Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result=await forgotPasswordUseCase(ForgotPasswordParams(email:event.email));
    result.fold(
      (failure)=>emit(AuthError(failure.message)),
      (_)=>emit(ForgotPasswordSuccess())
    );
  }

  Future<void> _onCheckBiometricRequired(CheckBiometricRequiredRequested event,
      Emitter<AuthState> emit) async {
    try {
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc._onCheckBiometricRequired: start');

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        debugPrint(
          '[BIOMETRIC_DEBUG] AuthBloc: no Firebase user — skip (do not emit Unauthenticated)',
        );
        return;
      }

      debugPrint(
        '[BIOMETRIC_DEBUG] AuthBloc: uid=${currentUser.uid} — calling CheckBiometricRequiredUseCase',
      );

      final result = await checkBiometricRequiredUseCase(NoParams());

      result.fold(
        (failure) {
          debugPrint(
            '[BIOMETRIC_DEBUG] AuthBloc: use case failure → ${failure.message}',
          );
          emit(AuthError(failure.message));
        },
        (isBiometricRequired) {
          if (isBiometricRequired) {
            debugPrint(
              '[BIOMETRIC_DEBUG] AuthBloc: emitting BiometricAuthenticationRequired '
              '(listener should show BiometricDialog)',
            );
            emit(BiometricAuthenticationRequired());
          } else {
            debugPrint(
              '[BIOMETRIC_DEBUG] AuthBloc: biometric not required → Authenticated',
            );
            emit(Authenticated());
          }
        },
      );
    } catch (e) {
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc._onCheckBiometricRequired error: $e');
      emit(AuthError('An error occurred while checking biometric required'));
    } finally {
      appLifecycleManager.resetPauseTime();
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc: resetPauseTime after biometric check');
    }
  }

  Future<void> _onAuthenticateWithBiometric(
    AuthenticateWithBiometricRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc: Starting biometric authentication...');
      final result = await biometricAuthenticationUseCase(
        BiometricAuthenticationParams(reason: event.reason),
      );
      result.fold(
        (failure) {
          debugPrint('[BIOMETRIC_DEBUG] AuthBloc: Biometric failed: ${failure.message}');
          emit(BiometricAuthenticationFailed(failure.message));
        },
        (_) {
          debugPrint('[BIOMETRIC_DEBUG] AuthBloc: Biometric successful');
          appLifecycleManager.resetPauseTime();

          emit(BiometricAuthenticationSuccess());

          Future.delayed(const Duration(milliseconds: 500), () {
            if (!isClosed) {
              emit(Authenticated());
            }
          });
        },
      );
    } catch (e) {
      debugPrint('[BIOMETRIC_DEBUG] AuthBloc: Error authenticating with biometric: $e');
      emit(AuthError('An error occurred while authenticating with biometric'));
    }
  }

  Future<void> _onBiometricDisableGate(
    BiometricDisableGateRequested event,
    Emitter<AuthState> emit,
  ) async {
    await biometricService.saveBiometricPreference(false);
    appLifecycleManager.resetPauseTime();
    emit(Authenticated());
  }

  @override
  Future<void> close() {
    appLifecycleManager.dispose();
    return super.close();
  }
}
