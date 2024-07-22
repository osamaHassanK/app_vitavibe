import 'package:flutter/material.dart';


import '../../other/widgets/text_widget.dart';
import '../dashboard/dashboard.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const CustomDrawer({required this.drawerKey,super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
             // margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AssetImage('assets/images/anshu-a-SURgxahMXPw-unsplash.jpg'),fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Vita Vibe',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'f',
                      fontSize: 40,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'VitaVibe.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'f',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const TextWidget(text: 'Home', fontSize: 16),
              onTap: () {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => const Dashboard()),
                  ModalRoute.withName('/dashboard'),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const TextWidget(text: 'Profile', fontSize: 16),
              onTap: () {
                Navigator.pushNamed(context,'/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lens_rounded),
              title: const TextWidget(text: 'About', fontSize: 16),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
        ListTile(
              leading: const Icon(Icons.settings_applications),
              title:const TextWidget(text: 'Settings', fontSize: 16),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
                // Navigator.pushAndRemoveUntil<void>(
                //   context,
                //   MaterialPageRoute<void>(builder: (BuildContext context) => const SettingsScreen()),
                //   ModalRoute.withName('/settings'),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
