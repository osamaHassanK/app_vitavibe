import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:app_vitavibe/other/firebase/fetch_notification/fetch_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationOverlay extends StatelessWidget {
  final VoidCallback closeMethod;

  const NotificationOverlay({super.key,required this.closeMethod});

  @override
  Widget build(BuildContext context) {
    AppDimensions dimension = AppDimensions(context);
    return Container(
      height: dimension.height * 0.4,
      width: dimension.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "f",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text('Notifications'),
                  ),
                ),
               Spacer(),
               InkWell(
                 onTap:closeMethod,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                   child: CircleAvatar(
                     maxRadius: 12,
                     backgroundColor: Colors.red,
                     child: Icon(Icons.close,color: Colors.white,),
                   ),
                 ),
               )
              ],
            ),
            Divider(color: Colors.grey[300]),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: FetchNotification.fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No notifications found.'));
                  } else {
                    List<Map<String, dynamic>> notifications = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        var notification = notifications[index];
                        String message = notification['message'] ?? 'No message';
                        Timestamp? timestamp = notification['timestamp'];
                        String formattedDate = timestamp != null
                            ? DateFormat('dd-MM-yyyy h:mm a').format(timestamp.toDate())
                            : 'No date';

                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'f',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'f',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey[300]),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
