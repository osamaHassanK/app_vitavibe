import 'package:alarm/alarm.dart';
import 'package:app_vitavibe/helpers/notification_scheduler_helper.dart';
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


NotificationSchedulerHelper notificationSchedulerHelper=NotificationSchedulerHelper();
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == 'periodicNotification') {
      checkAndShowNotification();
    }
    return Future.value(true);
  });
}



Future<void> checkAndShowNotification() async {
  final DateTime now = DateTime.now();
  final List<int> reminderDays = [1, 2, 3, 4, 5]; // Monday, Tuesday, Wednesday, Thursday, Friday
  final int reminderHour = 9;
  final int reminderMinute = 0;

  if (reminderDays.contains(now.weekday) )
    // &&
    //   now.hour == reminderHour &&
    //   now.minute == reminderMinute)
  {
    notificationSchedulerHelper.showPeriodicNotification();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await NotificationService.initializeNotification();
  await initializeFirebaseApp();



  //testing => Workmanager().registerOneOffTask('vitavibe', 'newTask');



  // final runAppInBackground = RunAppInBackground();
  // await runAppInBackground.initialize();
  // await runAppInBackground.startBackgroundTask();

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


