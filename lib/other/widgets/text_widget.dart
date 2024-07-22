import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const TextWidget({super.key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'f',
          fontSize: fontSize,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
