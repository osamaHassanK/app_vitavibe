import 'package:app_vitavibe/other/notification_service/notification_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../other/models/reminder_model.dart';
import '../../other/widgets/text_widget.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const TextWidget(text: 'Settings', fontSize: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Account',
              fontSize: 24,

            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person,color: Colors.black),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context,'/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock,color: Colors.black,),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.pushNamed(context,'/forgetPassword');
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback,color: Colors.black,),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            // SwitchListTile(
            //   title: const Text('Notifications'),
            //   value: true,
            //   onChanged: (bool value) {
            //     // Handle notifications toggle
            //   },
            // ),
            // const SizedBox(height: 20),
            // const TextWidget(
            //   text: 'More',
            //   fontSize: 24,
            // ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.info,color: Colors.black),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context,'/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share,color: Colors.black),
              title: const Text('Share With Friends'),
              onTap: () {
                Navigator.pushNamed(context,'/shareWithFriends');
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip,color: Colors.black,),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pushNamed(context, '/privacy-policy');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout,color: Colors.black,),
              title: const Text('Logout'),
              onTap: () async {
                final Box<Reminder> reminderBox = Hive.box<Reminder>('reminderBox');
                try {
                  await FirebaseAuth.instance.signOut();
                  await reminderBox.clear();
                  await AwesomeNotifications().cancelAllSchedules();
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) =>  LoginScreen()),
                    ModalRoute.withName('/'),
                  );
                } catch (e) {
                  print('Error signing out: $e');
                  // Handle error if needed
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
