import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFeedback(String userEmail, String feedback) async {

  final DocumentReference feedbackDoc = FirebaseFirestore.instance.collection('feedback').doc(userEmail);

  // Fetch the current feedback list
  final DocumentSnapshot docSnapshot = await feedbackDoc.get();
  List<dynamic> feedbackList = [];

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    feedbackList = data['feedback'] ?? [];
  }

  // Add the new feedback
  feedbackList.add({
    'email': userEmail,
    'feedback': feedback,
  });

  // Save the updated feedback list
  await feedbackDoc.set({
    'feedback': feedbackList,
  });
}
