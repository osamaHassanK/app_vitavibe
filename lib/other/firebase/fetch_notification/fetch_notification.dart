import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchNotification {
  static Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Get the current user's ID
      String userId = auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }

      // Fetch the user's document
      DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

      // Extract the notifications array
      List<Map<String, dynamic>> notifications = [];
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (data != null && data['notifications'] is List) {
          notifications = List<Map<String, dynamic>>.from(data['notifications'] ?? []);

          // Reverse the list to get the latest notifications first
          notifications = notifications.reversed.toList();
        }
      }

      print('Fetched notifications: $notifications');
      return notifications;
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }
}
