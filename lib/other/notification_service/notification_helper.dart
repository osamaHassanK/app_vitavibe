int dayToIndex(String day) {
  switch (day) {
    case 'Mon': return DateTime.monday;
    case 'Tue': return DateTime.tuesday;
    case 'Wed': return DateTime.wednesday;
    case 'Thu': return DateTime.thursday;
    case 'Fri': return DateTime.friday;
    case 'Sat': return DateTime.saturday;
    case 'Sun': return DateTime.sunday;
    default: return DateTime.monday; // Default to Monday if invalid day
  }
}

int calculateInterval(DateTime reminderTime, int dayIndex) {
  DateTime now = DateTime.now();
  DateTime nextReminder = DateTime(
    now.year,
    now.month,
    now.day,
    reminderTime.hour,
    reminderTime.minute,
  );

  // Adjust to the correct day of the week
  while (nextReminder.weekday != dayIndex) {
    nextReminder = nextReminder.add(Duration(days: 1));
  }

  // If the reminder time has already passed today, schedule for next week
  if (nextReminder.isBefore(now)) {
    nextReminder = nextReminder.add(Duration(days: 7));
  }

  return nextReminder.difference(now).inSeconds;
}
