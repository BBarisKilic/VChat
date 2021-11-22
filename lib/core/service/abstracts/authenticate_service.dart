import 'package:firebase_auth/firebase_auth.dart';
import '../../model/core_user.dart';

abstract class AuthenticateService {
  CoreUser? userFromUserCredential(User? user);
  Future<CoreUser?> registerWithEmailAndPassword(String email, String password);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
