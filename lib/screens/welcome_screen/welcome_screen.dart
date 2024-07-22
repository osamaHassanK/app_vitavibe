import 'package:flutter/material.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/widgets/glowingbuttonwidget.dart';
import '../../other/widgets/text_widget.dart';
import '../login_screen/login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final dimensions= AppDimensions(context);
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: dimensions.height,
            width: dimensions.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget(text: 'Simplify your health', fontSize: 30),
                const TextWidget(text: 'Tracking', fontSize: 30),
                SizedBox(
                  height: dimensions.height*0.2,
                    child: Image.asset('assets/images/pills.png',fit: BoxFit.cover,)),
                const TextWidget(text: 'Welcome to VitaVibe', fontSize: 30),
                SizedBox(
                  height: dimensions.height*0.25,
                  width: dimensions.width*0.8,
                  child: const TextWidget(text: 'Your ultimate companion for managing and enhancing your supplement intake. With Vita Vibe, stay on top of your health with personalized supplement management, timely reminders, and AI-driven suggestions for common ailments such as cough and viral infections.',
                      fontSize: 18),
                ),
                SizedBox(height: dimensions.height*0.05),
                GlowingButton(onPressed: (){
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) =>  LoginScreen()),
                    ModalRoute.withName('/'),
                  );
                }, title: "Get Started", height: dimensions.height*0.1, width: dimensions.width*0.8),
                SizedBox(height: dimensions.height*0.02),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}
