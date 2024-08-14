// import 'package:app_vitavibe/other/notification_service/flutter_local_noti/init_function.dart';
// import 'package:app_vitavibe/screens/reminder_screen/remider_widgets/add_medicine_dialogue.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:timezone/timezone.dart' as tz;
import 'package:app_vitavibe/other/notification_service/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:app_vitavibe/other/app_dimensions/app_dimensions.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:app_vitavibe/screens/reminder_screen/remider_widgets/date_and_time_generator.dart';
import 'package:app_vitavibe/screens/reminder_screen/remider_widgets/show_date_and_week_widget.dart';
import 'package:app_vitavibe/screens/reminder_screen/remider_widgets/medicine_container_widget.dart';

import '../../bloc/reminder_bloc/reminder_bloc.dart';
import '../../other/models/reminder_model.dart';


class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dimensions = AppDimensions(context);
    final DateAndTimeGenerator dateGenerator = DateAndTimeGenerator();
    final reminderBox = Hive.box<Reminder>('reminderBox');

    return BlocProvider(
      create: (context) => ReminderBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: InkWell(
          onTap: (){
            Navigator.pushNamed(
              context,
              '/addMedicine',
            );
          },
          child: Image.asset(
            'assets/icons/add.png',
            scale: 13,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: dimensions.height * 0.11,
                  width: dimensions.width * 0.932,
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: dateGenerator.dateList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime date = dateGenerator.dateTimeList[index];
                          String dayOfWeek = DateFormat('EEE')
                              .format(dateGenerator.dateTimeList[index]);
                          String dayOfMonth =
                          DateFormat('d').format(dateGenerator.dateTimeList[index]);
            
                          return showDateAndWeekName(
                            index: index,
                            selectedIndex: state.index, // Use state.index for comparison
                            dayOfWeek: dayOfWeek,
                            method: () {
                              dateGenerator.setSelectedDate(date);
                              print(dateGenerator.selectedDate);

                              // Dispatch an event to update the state
                              context.read<ReminderBloc>().add(
                                ClickedOnDateEvent(
                                  dateGenerator.dateTimeList[index],
                                  index,
                                ),
                              );
                            },
                            dayOfMonth: dayOfMonth,
                            context: context,
                          );
                        },
                      );
                    },
                  ),
                ),
                TextWidget(text: "Today's Medicines", fontSize: 24),
                BlocBuilder<ReminderBloc, ReminderState>(
                  builder: (context, state) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.604,
                      width: MediaQuery.of(context).size.width * 0.932,
                      child: ValueListenableBuilder(
                        valueListenable: reminderBox.listenable(),
                        builder: (context, Box<Reminder> box, _) {
                          final selectedDate = dateGenerator.selectedDate ?? DateTime.now();

// Filter reminders based on the selected date
                          final filteredReminders = reminderBox.values.where((reminder) {
                            return DateFormat('yyyy-MM-dd').format(reminder.reminderTime) ==
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          }).toList();

                          if (filteredReminders.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: dimensions.height * 0.2),
                                Image.asset('assets/images/vitamin.png', scale: 2),
                                SizedBox(height: dimensions.height * 0.02),
                                TextWidget(text: 'No Reminder Available', fontSize: 18),
                              ],
                            );
                          }

                          return ListView.builder(
                            itemCount: filteredReminders.isEmpty ? 0 : filteredReminders.length,
                            itemBuilder: (context, index) {
                              final reminder = filteredReminders[index];
                              String medicineImage;
                              switch (reminder.medicineType) {
                                case 'Injection':
                                  medicineImage = 'assets/icons/injection.png';
                                  break;
                                case 'Syrup':
                                  medicineImage = 'assets/icons/syrup.png';
                                  break;
                                default:
                                  medicineImage = 'assets/icons/capsule.png'; // Default image
                              }

                              return medicineContainerWidget(
                                deleteFunction: () {
                                  context.read<ReminderBloc>().add(DeleteReminderEvent(index));
                                },
                                weekDays: reminder.daysOfWeek,
                                medicineImage: medicineImage,
                                context: context,
                                dosage: reminder.dosage,
                                medicineName: reminder.medicineName,
                                medicineTime: reminder.reminderTime,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),


                // GlowingButton(onPressed: () {
                //   final notiTest = FlutterLocalNotification();
                //   int id =0 ;
                //   final soundFilePath = '/data/user/0/com.example.app_vitavibe/cache/file_picker/1722600419670/alberto_delrio.mp3'; // Replace with the actual path
                //   final scheduledDate =
                //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
                //   print('scehdule time $scheduledDate');
                //  notiTest.scheduleNotification(
                //      scheduledDate:scheduledDate ,
                //      soundFilePath: soundFilePath);
                //
                // }, title: 'test notification', height:50, width: 100,),
                //
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
