import 'package:app_vitavibe/other/Theme/colors.dart';
import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

Widget showDateAndWeekName({
  context,
  required String dayOfWeek,
  dayOfMonth,
  required VoidCallback method,
  required int index,
  selectedIndex,
}) {
  final dimensions = AppDimensions(context);
  return GestureDetector(
    onTap: method,
    child: Column(
      children: [
        Container(
          height: dimensions.height * 0.1,
          width: dimensions.width * 0.2,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color:
                index == selectedIndex ? AppColor.primaryColor : Colors.white,
            border: Border.all(
                color: index == selectedIndex ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${dayOfWeek}',
                style: TextStyle(
                    fontFamily: 'f',
                    color: index == selectedIndex ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '${dayOfMonth}',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'f',
                    color:
                        index == selectedIndex ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
