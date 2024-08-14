

import 'package:firebase_auth/firebase_auth.dart';

class LoginUserMethod {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  Future<User?> loginUser(String email, String password) async {

    try {
      UserCredential userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
