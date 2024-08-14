import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register user with email and password
  Future<void> registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      // Create user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user display name (optional)
      await result.user!.updateDisplayName(name);

      // Create a new document in Firestore for the user
      await _db.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
        // Add more fields as needed
      });
    } catch (error) {
      rethrow;
    }
  }
}
