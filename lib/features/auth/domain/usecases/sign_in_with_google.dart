import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/entities/user_entity.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle implements UseCase<UserEntity,NoParams>{
  final AuthRepository repository;
  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure,UserEntity>> call(NoParams params) async{
    return await repository.signInWithGoogle();
  }
}
class NoParams extends Equatable{
  const NoParams();
  @override
  List<Object> get props=>[];
}
