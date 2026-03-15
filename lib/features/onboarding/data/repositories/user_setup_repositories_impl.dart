import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/features/onboarding/data/datasources/user_setup_remote_datasources.dart';
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';
import 'package:routiner/features/onboarding/domain/repositories/user_setup_repositories.dart';

class UserSetupRepositoriesImpl implements UserSetupRepository{
  final UserSetupRemoteDatasource remoteDatasource;

  UserSetupRepositoriesImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure,void>> saveUserSetup(UserSetupEntity userSetup) async{
    try{

      final result=await remoteDatasource.saveUserSetup(userSetup);
      return Right(null);
    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }
}