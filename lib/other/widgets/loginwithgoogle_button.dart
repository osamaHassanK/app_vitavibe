

import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget signInWithGoogleButton(context,VoidCallback onPressed){
  AppDimensions dimension =AppDimensions(context);
  return GestureDetector(
    onTap:onPressed,
    child: Container(
      height: dimension.height * 0.08,
      width: dimension.width * 0.65,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/google.png'),
          SizedBox(width: dimension.width * 0.08),
          const TextWidget(
            text: "Login with Google",
            fontSize: 14,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );

}