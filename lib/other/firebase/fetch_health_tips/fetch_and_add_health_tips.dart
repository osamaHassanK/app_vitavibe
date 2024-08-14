import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchHealthTips {
  static Future<List<Map<String, dynamic>>> fetchHealthTips() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> healthTipList = [];

    try {
      // Fetch documents from the 'health_tips' collection
      QuerySnapshot querySnapshot = await _firestore.collection('healthTips').get();

      // Iterate through the documents and add them to the list
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        healthTipList.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching health tips: $e');
    }

    return healthTipList;
  }

  static Future<List<Map<String,dynamic>>> fetchAndPrintRandomHealthTips() async {
    List<Map<String, dynamic>> tips = await fetchHealthTips();

    if (tips.isEmpty) {
      print('No health tips available.');
    }

    // Create a random number generator
    Random random = Random();

    // Shuffle the list to get random tips
    tips.shuffle(random);

    // Select the first 5 tips from the shuffled list
    List<Map<String, dynamic>> randomTips = tips.take(15).toList();
    //
    // for (var tip in randomTips) {
    //   print(tip['tip']); // Assuming 'tip' is the key for the health tip text
    // }
    return tips;
  }
}
