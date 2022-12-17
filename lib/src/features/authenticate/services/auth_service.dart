import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/authenticate/domain/user_model.dart';

abstract class AuthService {
  Stream<UserModel> get authStateChanges;
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> registerAccount(
      String email, String password);
  void signOut();
}

final authRepositoryProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<UserModel> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return const UserModel(uid: null, email: null);
      }
    });
  }

  Future<bool> verifyEmail(
    String email,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> registerAccount(
    String email,
    String password,
  ) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _addUserDoc(credential.user!.uid);
      // await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _addUserDoc(String uid) async {
    await usersRef.doc(uid).set({'uid': uid});
  }
}
