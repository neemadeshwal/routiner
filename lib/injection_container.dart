import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routiner/core/services/app_lifecycle_manager.dart';
import 'package:routiner/core/services/biometric_service.dart';
import 'package:routiner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:routiner/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';
import 'package:routiner/features/auth/domain/usecases/biometric_authentication.dart';
import 'package:routiner/features/auth/domain/usecases/check_biometric_required.dart';
import 'package:routiner/features/auth/domain/usecases/forgot_password.dart';
import 'package:routiner/features/auth/domain/usecases/get_current_user.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_out.dart';
import 'package:routiner/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/onboarding/data/datasources/user_setup_remote_datasources.dart';
import 'package:routiner/features/onboarding/data/repositories/user_setup_repositories_impl.dart';
import 'package:routiner/features/onboarding/domain/repositories/user_setup_repositories.dart';
import 'package:routiner/features/onboarding/domain/usecases/save_user_setup_usecase.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ============================================
  // ✅ SERVICES - REGISTER FIRST
  // ============================================
  sl.registerSingleton<BiometricService>(BiometricService());
  sl.registerSingleton<AppLifecycleManager>(AppLifecycleManager());

  // ============================================
  // ✅ AUTH BLOC
  // ============================================
  sl.registerFactory(() => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        signOutUseCase: sl(),
        getCurrentUserUseCase: sl(),
        signInWithGoogleUseCase: sl(),
        forgotPasswordUseCase: sl(),
        biometricService: sl(),
        appLifecycleManager: sl(),
        biometricAuthenticationUseCase: sl(),  // ✅ Now registered below
        checkBiometricRequiredUseCase: sl(),   // ✅ Now registered below
      ));

  // ============================================
  // ✅ AUTH USE CASES
  // ============================================
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  
  // ✅ NEW: Register Biometric Use Cases
  sl.registerLazySingleton<BiometricAuthenticationUseCase>(
    () => BiometricAuthenticationUseCase(sl<BiometricService>()),
  );
  
  sl.registerLazySingleton<CheckBiometricRequiredUseCase>(
    () => CheckBiometricRequiredUseCase(
      biometricService: sl<BiometricService>(),
      appLifecycleManager: sl<AppLifecycleManager>(),
    ),
  );

  // ============================================
  // ✅ AUTH REPOSITORY
  // ============================================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImpl(remoteDatasource: sl()),
  );

  // ============================================
  // ✅ AUTH DATA SOURCES
  // ============================================
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );

  // ============================================
  // ✅ FIREBASE INSTANCES
  // ============================================
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);

  // ============================================
  // ✅ USER SETUP BLOC & USE CASES
  // ============================================
  sl.registerFactory(() => UserSetupBloc(saveUserSetupUseCase: sl()));
  sl.registerLazySingleton(() => SaveUserSetupUsecase(sl()));

  // ============================================
  // ✅ USER SETUP REPOSITORY & DATA SOURCES
  // ============================================
  sl.registerLazySingleton<UserSetupRepository>(
    () => UserSetupRepositoriesImpl(remoteDatasource: sl()),
  );

  sl.registerLazySingleton<UserSetupRemoteDatasource>(
    () => UserSetupRemoteDatasourceImpl(firestore: sl()),
  );
}