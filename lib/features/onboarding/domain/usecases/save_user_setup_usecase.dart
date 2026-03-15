import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/core/usecases/usecase.dart';
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';
import 'package:routiner/features/onboarding/domain/repositories/user_setup_repositories.dart';

class SaveUserSetupUsecase implements UseCase<void,UserSetupEntity>{

 final UserSetupRepository repository;

 SaveUserSetupUsecase(this.repository);

 @override 
 Future<Either<Failure,void>> call(UserSetupEntity userSetup) async{
  return await repository.saveUserSetup(userSetup);
 }
}

class SaveUserSetupParams extends Equatable{
  final UserSetupEntity userSetup;
  const SaveUserSetupParams({required this.userSetup});

  @override
  List<Object?> get props=>[userSetup];
}