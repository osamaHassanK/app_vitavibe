import 'package:app_vitavibe/screens/ai_based_medicine_suggestions/ai_based_medicine_suggestions.dart';
import 'package:app_vitavibe/screens/feedback_screen/feedback_screen.dart';
import 'package:app_vitavibe/screens/guide_screen/detailed_guidance_screen.dart';
import 'package:app_vitavibe/screens/profile_screen/profile_screen.dart';
import 'package:app_vitavibe/screens/reminder_screen/remider_widgets/add_medicine_dialogue.dart';
import 'package:app_vitavibe/screens/reminder_screen/reminder_screen.dart';
import 'package:app_vitavibe/screens/share_with_friends/share_with_friends_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../screens/about_screen/about_screen.dart';
import '../../screens/authentication_wrapper/authentication_wrapper.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/forgetPassword_screen/forget_password_screen.dart';
import '../../screens/privacy_policy_screen/privacy_policy_screen.dart';
import '../../screens/settings_screen/settings_screen.dart';
import '../../screens/signin_screen/signin_screen.dart';
import '../../screens/welcome_screen/welcome_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const AuthenticationWrapper(),
    '/welcome': (context) => const WelcomeScreen(),
    '/register': (context) => const RegistrationScreen(),
    '/dashboard': (context) => const Dashboard(),
    '/reminder-screen': (context) => const ReminderScreen(),
    '/settings': (context) => const SettingsScreen(),
    '/about': (context) => const AboutScreen(),
    '/privacy-policy': (context) => const PrivacyPolicyScreen(),
    '/detailed-guidance': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return DetailedGuidanceScreen(
        supplementName: args['supplementName'] ?? 'Default Name',
        supplementUrl: args['supplementUrl'] ?? '',
        supplementsDetails:
            args['supplementsDetails'] ?? 'No details provided.',
        supplementsBenefits:
            args['supplementsBenefits'] ?? 'No benefits listed.',
        interactionWarningOfSupplement:
            args['interactionWarningOfSupplement'] ?? 'No warnings provided.',
        supplementDosage: args['supplementDosage'] ?? 'No dosage information.',
      );
    },
    '/profile': (context) => const ProfileScreenView(),
    '/forgetPassword': (context) => ForgotPasswordScreen(),
    '/shareWithFriends': (context) => ShareWithFriendScreen(),
    '/feedback': (context) => AddFeedbackScreen(),
    '/addMedicine': (context) => AddMedicineScreen(),
    '/addReminder': (context) => const ReminderScreen(),
    '/aiBasedMedicineSuggestions': (context) => const AiBasedMedicineSuggestions(),
  };
}
