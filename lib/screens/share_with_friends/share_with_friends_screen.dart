import 'package:app_vitavibe/other/widgets/glowingbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../other/app_dimensions/app_dimensions.dart';

class ShareWithFriendScreen extends StatelessWidget {
  const ShareWithFriendScreen({Key? key}) : super(key: key);

  void _shareContent(BuildContext context) {
    final String text = 'Check out this awesome app: Vitavibe.com';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = AppDimensions(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'VitaVibe',
          style: TextStyle(
            fontFamily: 'f',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: dimensions.height * 0.02),
            Image.asset(
              'assets/images/pills.png',
              scale: 3,
            ),
            const Text(
              'Invite Your Friends',
              style: TextStyle(
                fontFamily: 'f',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Share the app with your friends and let them join the fun!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'f',
                fontSize: 16,
              ),
            ),
             SizedBox(height: dimensions.height*0.05),
            GlowingButton(
              onPressed: () => _shareContent(context),
              title: 'Share via',
              height: dimensions.height * 0.08,
              width: dimensions.width * 0.8,
            ),
            SizedBox(height: dimensions.height*0.05),
            const Text(
              'You can share the app link with your friends via various platforms.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'f',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
