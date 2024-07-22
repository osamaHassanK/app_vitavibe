import 'package:app_vitavibe/screens/feedback_screen/feedback_screen.dart';
import 'package:app_vitavibe/screens/guide_screen/detailed_guidance_screen.dart';
import 'package:app_vitavibe/screens/profile_screen/profile_screen.dart';
import 'package:app_vitavibe/screens/share_with_friends/share_with_friends_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/about_screen/about_screen.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/forgetPassword_screen/forget_password_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/privacy_policy_screen/privacy_policy_screen.dart';
import '../../screens/settings_screen/settings_screen.dart';
import '../../screens/signin_screen/signin_screen.dart';
import '../../screens/welcome_screen/welcome_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginScreen(),
    '/welcome': (context)=> const WelcomeScreen(),
    '/register': (context) => const RegistrationScreen(),
    '/dashboard': (context) => const Dashboard(),
    '/settings': (context) => const SettingsScreen(),
    '/about': (context) => const AboutScreen(),
    '/privacy-policy': (context) => const PrivacyPolicyScreen(),
    '/detailed-guidance': (context) =>  DetailedGuidanceScreen(supplementUrl:'',interactionWarningOfSupplement: '',supplementDosage: '',supplementName: '',supplementsBenefits: '',supplementsDetails: '',),
    '/profile': (context) => const ProfileScreenView(),
    '/forgetPassword': (context) => ForgotPasswordScreen(),
    '/shareWithFriends':(context)=> ShareWithFriendScreen(),
    '/feedback':(context)=> AddFeedbackScreen(),
  };

}
