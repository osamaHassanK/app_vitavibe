import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<String?> getImageUrlFromFirestore() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    print(userId);
    if (snapshot.exists) {
      String? imageUrl = snapshot.data()?['profileImageUrl'];
      return imageUrl;
    } else {
      print('Document does not exist');
      return null;
    }
  } catch (e) {
    print('Error fetching image URL: $e');
    return null;
  }
}

