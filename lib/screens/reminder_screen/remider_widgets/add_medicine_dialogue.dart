import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:app_vitavibe/other/notification_service/flutter_local_noti/init_function.dart';
import 'package:app_vitavibe/other/test/test_audio_playback/test_audio_playback.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_vitavibe/other/widgets/custom_textformfield.dart';
import 'package:app_vitavibe/other/widgets/glowingbuttonwidget.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import '../../../bloc/reminder_bloc/reminder_bloc.dart';
import '../../../other/notification_service/notification_service.dart';
import '../../../other/app_dimensions/app_dimensions.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String formatTimeOfDay(TimeOfDay time) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = AppDimensions(context);

    return BlocProvider(
      create: (context) => ReminderBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          title: const Text(
            'Add Medicine',
            style: TextStyle(fontSize: 24, fontFamily: 'f'),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<ReminderBloc, ReminderState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: "Medicine Name", fontSize: 18),
                      CustomTextFormField(
                        hintText: 'Medicine name',
                        showPass: () {},
                        isShowIcon: false,
                        onChanged: (value) {
                          context
                              .read<ReminderBloc>()
                              .add(MedicineNameChanged(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the medicine name';
                          }
                          return null;
                        },
                      ),
                      TextWidget(text: "Dosage", fontSize: 18),
                      CustomTextFormField(
                        hintText: 'Dosage',
                        showPass: () {},
                        isShowIcon: false,
                        onChanged: (value) {
                          context
                              .read<ReminderBloc>()
                              .add(DosageChanged(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the dosage';
                          }
                          return null;
                        },
                      ),
                      TextWidget(text: "Medicine Type", fontSize: 18),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          style:
                              TextStyle(fontFamily: 'f', color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                          value: state.medicineType.isNotEmpty
                              ? state.medicineType
                              : 'Supplement', // Provide a default value if `medicineType` is empty
                          items: <String>['Supplement', 'Injection', 'Syrup']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              context
                                  .read<ReminderBloc>()
                                  .add(MedicineTypeChanged(newValue));
                            }
                          },
                          isExpanded: true,
                          underline: SizedBox(), // Hide the default underline
                        ),
                      ),
                      TextWidget(text: "Select Week", fontSize: 18),
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ChoiceChip(
                              label: Text('Mon'),
                              selected: state.selectedWeekDays.contains('Mon'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Mon');
                                } else {
                                  selectedDays.remove('Mon');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Tue'),
                              selected: state.selectedWeekDays.contains('Tue'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Tue');
                                } else {
                                  selectedDays.remove('Tue');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Wed'),
                              selected: state.selectedWeekDays.contains('Wed'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Wed');
                                } else {
                                  selectedDays.remove('Wed');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Thu'),
                              selected: state.selectedWeekDays.contains('Thu'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Thu');
                                } else {
                                  selectedDays.remove('Thu');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Fri'),
                              selected: state.selectedWeekDays.contains('Fri'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Fri');
                                } else {
                                  selectedDays.remove('Fri');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Sat'),
                              selected: state.selectedWeekDays.contains('Sat'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Sat');
                                } else {
                                  selectedDays.remove('Sat');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                              selectedColor:
                                  Colors.green, // Color for the selected state
                              backgroundColor: Colors.black,
                              label: Text('Sun'),
                              selected: state.selectedWeekDays.contains('Sun'),
                              onSelected: (selected) {
                                final selectedDays =
                                    List<String>.from(state.selectedWeekDays);
                                if (selected) {
                                  selectedDays.add('Sun');
                                } else {
                                  selectedDays.remove('Sun');
                                }
                                context
                                    .read<ReminderBloc>()
                                    .add(WeekDaysSelected(selectedDays));
                              },
                            ),
                          ],
                        ),
                      ),
                      TextWidget(text: "Time", fontSize: 18),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: Colors
                                          .green, // Color of the selection
                                      hintColor: Colors
                                          .green, // Color of the accent elements
                                      buttonTheme: ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                      timePickerTheme: TimePickerThemeData(
                                        dialHandColor: Colors
                                            .green, // Color of the time picker dial
                                        dialTextColor: Colors
                                            .green, // Color of the time picker text
                                        backgroundColor: Colors
                                            .white, // Background color of the time picker
                                        hourMinuteTextColor: Colors
                                            .green, // Color of the hour and minute text
                                        hourMinuteShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        entryModeIconColor: Colors
                                            .green, // Color of the entry mode icon
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                context
                                    .read<ReminderBloc>()
                                    .add(TimeSelectedEvent(picked));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Select Time',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'f'),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              formatTimeOfDay(state.selectedTime),
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'f'),
                            ),
                          ),
                        ],
                      ),
                      // TextWidget(text: "Notification Sound", fontSize: 18),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () async {
                      //         final result =
                      //             await FilePicker.platform.pickFiles(
                      //           type: FileType.audio,
                      //         );
                      //
                      //         if (result != null && result.files.isNotEmpty) {
                      //           final audioPath = result.files.single.path;
                      //           if (audioPath != null) {
                      //             context
                      //                 .read<ReminderBloc>()
                      //                 .add(AudioFileSelected(audioPath));
                      //           }
                      //         }
                      //       },
                      //       child: Container(
                      //         padding: EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //           color: Colors.black,
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         child: Text(
                      //           'Select Audio',
                      //           style: TextStyle(
                      //               color: Colors.white, fontFamily: 'f'),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Container(
                      //       width: dimensions.width * 0.45,
                      //       height: dimensions.height * 0.05,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(8),
                      //         color: state.audioFilePath.isNotEmpty
                      //             ? Colors.green
                      //             : Colors.black,
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           state.audioFilePath.isNotEmpty
                      //               ? '${state.audioFilePath.split('/').last}'
                      //               : 'No audio selected',
                      //           overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontFamily: 'f',
                      //               fontSize: 16),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      Center(
                        child: GlowingButton(
                          onPressed: () async {
                            // DateTime selectedDate = DateTime.now(); // Use the current date or provide a specific date
                            //
                            // DateTime dateTime = DateTime(
                            //   selectedDate.year,
                            //   selectedDate.month,
                            //   selectedDate.day,
                            //   state.selectedTime.hour,
                            //   state.selectedTime.minute,
                            // );
                            //
                            // Alarm.set(alarmSettings: AlarmSettings(
                            //   id: 42,
                            //   dateTime: dateTime, // Use the combined DateTime here
                            //   assetAudioPath: 'assets/sound/reminderSound.mp3',
                            //   loopAudio: true,
                            //   vibrate: true,
                            //   volume: 0.8,
                            //   fadeDuration: 3.0,
                            //   notificationTitle: 'This is the title',
                            //   notificationBody: 'This is the body',
                            //   enableNotificationOnKill: true,
                            // ));

                            if ((_formKey.currentState?.validate() ?? false) && state.selectedWeekDays.isNotEmpty) {
                              context.read<ReminderBloc>().add(SaveReminderEvent());
                              Navigator.pushNamed(context, '/dashboard');
                            } else {
                              final localNoti = FlutterLocalNotification();
                              int id = 0;
                              localNoti.showNotification(
                                id++,
                                "VitaVibe",
                                "Please fill out all required fields before submitting.",
                              );
                            }

                          },
                          title: 'Submit',
                          height: dimensions.height * 0.08,
                          width: dimensions.width * 0.4,
                        ),
                      ),

                  // ==>  alarm package testing

                      // Center(
                      //   child: GlowingButton(
                      //     onPressed: () async {
                      //       await Alarm.stop(42);
                      //     },
                      //     title: 'Submit',
                      //     height: dimensions.height * 0.08,
                      //     width: dimensions.width * 0.4,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // Future<void> handleNotification(String audioFilePath) async {
  //   // Play the audio file
  //   await testAudioPlayback(audioFilePath);
  //
  //   // Convert local file path to URI if needed
  //   if (audioFilePath.contains('/')) {
  //     audioFilePath = Uri.file(audioFilePath).toString();
  //   }
  //
  //   // Show notification
  //   await NotificationService.showNotification(
  //     title: 'Medicine Reminder',
  //     body: 'Time to take your medicine.',
  //     soundSource: audioFilePath,
  //     scheduled: true,
  //     interval: 6, // example interval
  //   );
  // }
}
