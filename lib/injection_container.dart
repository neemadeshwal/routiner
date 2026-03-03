import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:routiner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:routiner/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(signInUseCase: sl(), signUpUseCase: sl()));

  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImpl(remoteDatasource: sl()),
  );
  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(()=>FirebaseFirestore.instance);
}
