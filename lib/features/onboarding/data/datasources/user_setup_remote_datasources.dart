import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routiner/core/error/exception.dart';
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';

abstract class UserSetupRemoteDatasource{
  Future<void> saveUserSetup(UserSetupEntity userSetup);

}

class UserSetupRemoteDatasourceImpl implements UserSetupRemoteDatasource{
  final FirebaseFirestore firestore;

  UserSetupRemoteDatasourceImpl({required this.firestore});

  @override
  Future<void> saveUserSetup(UserSetupEntity userSetup) async {
    try {
      await firestore.collection('users').doc(userSetup.userId).set(
            {
              'onboardingComplete': true,
              'userSetup': userSetup.toJson(),
            },
            SetOptions(merge: true),
          );
    }
    on FirebaseException catch (e){
      throw UserSetupException(e.message ?? 'Failed to save user setup');
    }
    catch(e){
      throw ServerException(e.toString());
    }
  }
}