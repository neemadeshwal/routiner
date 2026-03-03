import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:routiner/core/error/exception.dart';
import 'package:routiner/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String userName,
  );
  // Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  // final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    // required this.googleSignIn,
  });
  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCreds = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCreds.user == null) {
        throw AuthException("Sign in failed");
      }
      return UserModel.fromFirebaseUser(userCreds.user!);
    } catch (e) {
      throw AuthException("An unexpected error occured.");
    }
  }

  @override
  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final userCreds = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCreds.user == null) {
        throw AuthException("Sign up failed");
      }
      return UserModel.fromFirebaseUser(userCreds.user!);
    } catch (e) {
      throw AuthException("An Unexpected error occured.");
    }
  }
}
