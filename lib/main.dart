import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/profile_bloc/profile_bloc.dart';
import 'other/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDfsHZ7ovHwz4haCZKGqjKb8uRjlVp6ZQs',
      appId: '1:692372681998:android:f39f16a9d17a4ac23a935f',
      messagingSenderId: '692372681998',
      projectId: 'vitavibe-app',
      storageBucket:"vitavibe-app.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if user is authenticated
    bool isAuthenticated = FirebaseAuth.instance.currentUser != null;

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: isAuthenticated ? '/dashboard' : '/welcome',
        routes: Routes.routes,
      ),
    );
  }
}
