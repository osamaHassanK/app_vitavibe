import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDfsHZ7ovHwz4haCZKGqjKb8uRjlVp6ZQs',
      appId: '1:692372681998:android:f39f16a9d17a4ac23a935f',
      messagingSenderId: '692372681998',
      projectId: 'vitavibe-app',
      storageBucket: 'vitavibe-app.appspot.com',
    ),
  );
}
