import 'package:bloc/bloc.dart';
import 'package:routiner/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:routiner/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInUseCase;
  final SignUpWithEmail signUpUseCase;

  AuthBloc({required this.signInUseCase, required this.signUpUseCase})
    : super(AuthInitial()) {
    //Register event handlers
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
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

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated()),
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

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated()),
    );
  }
}
