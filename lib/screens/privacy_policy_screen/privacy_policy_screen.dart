import 'package:flutter/material.dart';

import '../../other/widgets/text_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const TextWidget(text: 'Privacy Policy', fontSize: 24),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your privacy is important to us. It is our policy to respect your privacy regarding any information we may collect from you across our application, vitavibe.com, and other sites we own and operate.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '1. Information we collect',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Log data: When you use our application, our servers may automatically log the standard data provided by your device. This data is considered "non-identifying information," as it does not personally identify you on its own.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '2. Legal bases for processing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'We will process your personal information lawfully, fairly and in a transparent manner. We collect and process information about you only where we have legal bases for doing so.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '3. Collection and use of information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'We may collect personal information from you when you do any of the following on our application:\n- Use a mobile device or web browser to access our content\n- Contact us via email, social media, or on any similar technologies\n- When you mention us on social media',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '4. Security of your personal information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'When we collect and process personal information, and while we retain this information, we will protect it within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '5. Children’s Privacy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'We do not knowingly collect or store personally identifiable information from children under the age of 13.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '6. Changes to this policy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'At our discretion, we may change our privacy policy to reflect current acceptable practices. We will take reasonable steps to let users know about changes via our application.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '7. Contact Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'f',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'If you have any questions about this policy or our practices, please contact us at vitavibe@gmail.com.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'f',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
