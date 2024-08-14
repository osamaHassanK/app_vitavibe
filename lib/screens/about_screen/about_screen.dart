import 'package:flutter/material.dart';

import '../../other/widgets/text_widget.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.black12,
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const TextWidget(text: 'Vita Vibe', fontSize: 24),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'About Vita Vibe',
              fontSize: 24,
            ),
            SizedBox(height: 20),
            Text(
              'Vita Vibe is a comprehensive app designed to help you achieve your health and wellness goals. '
                  'We provide personalized recommendations, tracking tools, and community support to help you stay motivated and on track.',
              style: TextStyle(fontSize: 16,
                  fontFamily: 'f'
              ),
            ),
            SizedBox(height: 20),
            TextWidget(
              text: 'Our Mission',
              fontSize: 20,
            ),
            SizedBox(height: 10),
            Text(
              'Our mission is to empower individuals to lead healthier and happier lives by providing easy access to reliable health and wellness information, tools, and community support.',
              style: TextStyle(fontSize: 16,
                  fontFamily: 'f'
              ),
            ),
            SizedBox(height: 20),
            TextWidget(
              text: 'Contact Us',
              fontSize: 20,
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or feedback, feel free to reach out to us at contact@vitavibe.com.',
              style: TextStyle(fontSize: 16,
                  fontFamily: 'f'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
