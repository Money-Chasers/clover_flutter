import 'package:clover_flutter/bloc/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  static final _authInstance = FirebaseAuth.instance;
  static FirebaseAuth get authInstance => _authInstance;
  static UserModel get currentUser {
    User? _currentUser = _authInstance.currentUser;
    if (_currentUser != null) {
      return UserModel(
          userId: _currentUser.uid,
          userDetails: UserDetails(
              name: _currentUser.displayName.toString(),
              email: _currentUser.email.toString()),
          isSignedIn: true);
    } else {
      return UserModel(
          userId: '',
          userDetails: UserDetails(name: '', email: ''),
          isSignedIn: false);
    }
  }

  static Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) {
    return _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<void> signOut() {
    return _authInstance.signOut();
  }

  static Future verifyUserPassword(String oldEmail, String password) {
    return _authInstance.signInWithEmailAndPassword(
        email: oldEmail, password: password);
  }

  static Future updateUserPassword(oldPassword, newPassword) {
    return _authInstance
        .signInWithEmailAndPassword(
            email: currentUser.userDetails.email, password: oldPassword)
        .then((value) {
      _authInstance.currentUser!.updatePassword(newPassword);
    });
  }
}
