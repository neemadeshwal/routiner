import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/auth/domain/repositories/auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await repository.signOut();
  }
}
