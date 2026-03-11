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
  Future<UserModel?> getCurrentUser();
  Future<void> signOut();
  Future<UserModel> signInWithGoogle();
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });
  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCreds = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCreds.user == null) throw AuthException("Sign in failed");
      return UserModel.fromFirebaseUser(userCreds.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Sign in failed');
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
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
      if (userCreds.user == null) throw AuthException("Sign up failed");
      await userCreds.user!.updateDisplayName(userName);
      await userCreds.user!.reload();
      final updatedUser = firebaseAuth.currentUser!;
      return UserModel.fromFirebaseUser(updatedUser);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Sign up failed');
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
    }
  }
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Failed to get user');
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Sign out failed');
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;
      if (idToken == null) throw AuthException("Sign in failed");
      final userCreds = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      if (userCreds.user == null) throw AuthException("Sign in failed");
      return UserModel.fromFirebaseUser(userCreds.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Google sign in failed');
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
    }
  }
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // e.g. user-not-found, invalid-email, too-many-requests
      throw AuthException(e.message ?? 'Password reset failed');
    } catch (e) {
      throw AuthException("An unexpected error occurred");
    }
  }
}
