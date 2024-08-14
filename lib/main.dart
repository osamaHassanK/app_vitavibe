import 'package:alarm/alarm.dart';
import 'package:app_vitavibe/other/firebase/initialize_firebase_app/initialize_firebase_app.dart';
import 'package:app_vitavibe/other/flutter_background/flutter_background.dart';
import 'package:app_vitavibe/other/notification_service/flutter_local_noti/init_function.dart';
import 'package:app_vitavibe/other/notification_service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:workmanager/workmanager.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/profile_bloc/profile_bloc.dart';
import 'other/local_time_zone/configure_local_time_zone.dart';
import 'other/models/reminder_model.dart';
import 'other/routes/routes.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case 'newTask':
       // NotificationService.showNotification(title: 'New task', body: "App is alive");
      // uncomment if you want to check
        break;
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await NotificationService.initializeNotification();
  await initializeFirebaseApp();

  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "1",
    "newTask",
    frequency: Duration(minutes: 15),
  ).then((value) =>
    print('periodic task registered')
    //testing =>  NotificationService.showNotification(title: 'new Task Status WorkManager', body:'periodic task registered')
  )
      .catchError((e) =>
      print('Error registering task: $e')
     //testing => NotificationService.showNotification(title: 'new Task Status WorkManager', body:'Error registering task: $e')
  );

  //testing => Workmanager().registerOneOffTask('vitavibe', 'newTask');



  final runAppInBackground = RunAppInBackground();
  await runAppInBackground.initialize();
  await runAppInBackground.startBackgroundTask();

  await Alarm.init();

  await configureLocalTimeZone();
  final localNotification = FlutterLocalNotification();
  await localNotification.initNotification();



  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<Reminder>('reminderBox');

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          title: 'VitaVibe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: Routes.routes),
    );
  }
}


