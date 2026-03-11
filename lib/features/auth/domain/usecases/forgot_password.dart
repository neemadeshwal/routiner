import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class ForgotPassword implements UseCase<void, ForgotPasswordParams>{

 final AuthRepository repository;
 ForgotPassword(this.repository);

 @override
 Future<Either<Failure,void>> call(ForgotPasswordParams params) async{
  return await repository.forgotPassword(params.email);
 }
}

class ForgotPasswordParams extends Equatable{
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object> get props=>[email];
  
}