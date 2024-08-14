import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNotificationFirebase {
  static Future<void> addNotificationToFirebase({required String notification}) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final timestamp = DateTime.now(); // Use client-side timestamp

        // Add a new notification with a client-side timestamp
        await _db.collection('users').doc(userId).update({
          'notifications': FieldValue.arrayUnion([
            {'message': notification, 'timestamp': timestamp}
          ]),
        });
      }
    } catch (e) {
      if (e is FirebaseException && e.code == 'not-found') {
        // Handle the case where the document doesn't exist yet
        final userId = _auth.currentUser?.uid;
        if (userId != null) {
          final timestamp = DateTime.now(); // Use client-side timestamp

          await _db.collection('users').doc(userId).set({
            'notifications': [
              {'message': notification, 'timestamp': timestamp}
            ],
          });
        }
      } else {
        rethrow;
      }
    }
  }
}
