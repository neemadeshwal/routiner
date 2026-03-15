import 'package:dartz/dartz.dart';
import 'package:routiner/core/error/failure.dart';
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';

abstract class UserSetupRepository{
  Future<Either<Failure,void>> saveUserSetup(UserSetupEntity userSetup);
}