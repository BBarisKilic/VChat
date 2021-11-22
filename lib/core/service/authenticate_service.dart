import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/core_user.dart';

class AuthenticateService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CoreUser? _userFromUserCredential(User? _user) {
    return _user != null ? CoreUser(uid: _user.uid) : null;
  }

  Future<CoreUser?> registerWithEmailAndPassword(
      String _email, String _password) async {
    try {
      final UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: _email, password: _password);
      final User? _user = _userCredential.user;
      return _userFromUserCredential(_user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String _email, String _password) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      final User? _user = _userCredential.user;
      return _user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
