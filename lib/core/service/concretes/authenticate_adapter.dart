import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../abstracts/authenticate_service.dart';
import '../../model/core_user.dart';

class AuthenticateAdapter implements AuthenticateService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  CoreUser? userFromUserCredential(User? user) {
    return user != null ? CoreUser(uid: user.uid) : null;
  }

  @override
  Future<CoreUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? _user = _userCredential.user;
      return userFromUserCredential(_user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? _user = _userCredential.user;
      return _user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
