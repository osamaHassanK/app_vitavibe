import 'package:flutter/material.dart';

class AppDimensions {
  late final double height;
  late final double width;

  AppDimensions(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
