import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

class NotificationOverlay extends StatelessWidget {
  final String message;

  const NotificationOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    AppDimensions dimension =AppDimensions(context);
    return Container(
      height: dimension.height*0.4,
      width: dimension.width*0.04,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black12), // Optional subtle border
        borderRadius:
        BorderRadius.circular(12), // Smooth rounded corners
      color: Colors.white,
        boxShadow: [
          // Subtle shadow for depth
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15, // Placeholder for the number of notifications
        itemBuilder: (context, index) {
          return Material(
            borderRadius:
            BorderRadius.circular(12),
            color: Colors.white,
            child: ListTile(
              leading: Image.asset('assets/icons/notification.png',scale: 3,),
              title: Text('Notification ${index + 1}'),
              subtitle: Text(message),
             // trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            ),
          );
        },
      ),


    );
  }
}
// padding: EdgeInsets.all(16.0),
// decoration: BoxDecoration(
// //  color: Colors.black.withOpacity(0.8),
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(10.0),
// ),
// child: Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Expanded(
//       child: Text(
//         message,
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     IconButton(
//       icon: Icon(Icons.close, color: Colors.white),
//       onPressed: () {
//         Overlay.of(context)!.dispose();
//       },
//     ),
//   ],
// ),