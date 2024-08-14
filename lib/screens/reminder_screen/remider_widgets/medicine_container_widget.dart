import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget medicineContainerWidget({context,required String medicineImage,medicineName,dosage,medicineTime,
  required List<dynamic> weekDays,required Function deleteFunction
}) {
  final dimensions = AppDimensions(context);
  String formattedTime = DateFormat('h:mm a').format(medicineTime);
  return GestureDetector(
    onTap: (){
      showDeleteConfirmationDialog(context, deleteFunction);
    },
    child: Container(
      height: dimensions.height * 0.17,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: dimensions.width * 0.05),
              Image.asset(
                medicineImage,
                scale: 2.5,
              ),
              SizedBox(width: dimensions.width * 0.09),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: dimensions.height * 0.01),
                  SizedBox(
                    width: dimensions.width*0.4,
                    child: Text(
                      medicineName,
                      style: TextStyle(fontSize: 30, fontFamily: 'f',
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Text(
                    dosage,
                    style: TextStyle(fontSize: 13, fontFamily: 'f',
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
              SizedBox(width: dimensions.width * 0.02),
              Column(
                children: [
                  SizedBox(height: dimensions.height * 0.033),
                  Image.asset(
                    'assets/icons/clock.png',
                    scale: 10,
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(fontSize: 13, fontFamily: 'f'),
                  ),
                ],
              ),

            ],
          ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getSortedWeekDays(weekDays).map((day) {
            return Container(
              margin: EdgeInsets.only(right: 4),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black,
              ),
              child: Text(
                day,
                style: TextStyle(fontSize: 12, fontFamily: 'f', color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    ),
    ],
      ),
    ),
  );
}

List<dynamic> _getSortedWeekDays(List<dynamic> weekDays) {
  List<dynamic> allWeekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // Sort the saved weekdays based on the predefined order in allWeekDays
  weekDays.sort((a, b) => allWeekDays.indexOf(a).compareTo(allWeekDays.indexOf(b)));

  return weekDays;
}

void showDeleteConfirmationDialog(BuildContext context, Function onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          'Delete Reminder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this reminder?',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey, // Text color
            ),
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Delete'),
            onPressed: () {
              onConfirm(); // Execute the confirmation action
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
