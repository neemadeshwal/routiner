import 'package:bloc/bloc.dart';
import 'package:routiner/core/usecases/usecase.dart';
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

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
    required this.signInWithGoogleUseCase,
    required this.forgotPasswordUseCase
  }) : super(AuthInitial()) {
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getCurrentUserUseCase(const NoParams());
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) => user != null ? emit(Authenticated()) : emit(Unauthenticated()),
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

  Future<void> _onSignOutRequested(SignOutRequested event,Emitter<AuthState> emit) async{
    emit(AuthLoading());
    final result=await signOutUseCase(NoParams());
    result.fold(
      (failure)=>emit(AuthError(failure.message)),
      (user)=>emit(Unauthenticated())
    );}

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signInWithGoogleUseCase(const google_usecase.NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated()),
    );
  } 

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event,Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result=await forgotPasswordUseCase(ForgotPasswordParams(email:event.email));
    result.fold(
      (failure)=>emit(AuthError(failure.message)),
      (_)=>emit(ForgotPasswordSuccess())
    );
  }

  
}
