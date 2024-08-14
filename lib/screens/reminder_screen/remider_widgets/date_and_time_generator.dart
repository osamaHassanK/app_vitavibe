import 'package:intl/intl.dart';

class DateAndTimeGenerator {
  DateTime startDate = DateTime.now();
  List<String> dateList = [];
  List<DateTime> dateTimeList = [];
  DateTime? selectedDate ;

  DateFormat dateFormat = DateFormat('EEE, d-MMM-yyyy');

  DateAndTimeGenerator() {
    generateDates();
  }

  void generateDates() {
    int currentYear = startDate.year;
    int currentMonth = startDate.month;

    // Get the number of days in the current month
    int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    // Adjust the loop to iterate through all days in the month
    for (int i = 0; i < daysInMonth; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String formattedDate = dateFormat.format(currentDate);
      dateList.add(formattedDate);
      dateTimeList.add(currentDate);
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }

  // Method to check if a date is selected
  bool isSelected(DateTime date) {
    return selectedDate != null && date.isAtSameMomentAs(selectedDate!);
  }

  // Method to get the selected date
  DateTime? getSelectedDate() {
    return selectedDate;
  }
}
