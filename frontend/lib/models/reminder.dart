enum ReminderType { petRoutine, checkUp, vaccineSchedule }

class Reminder {
  final String name; // The reminder name (e.g., "Vet Visit", "Feed Pet")
  final ReminderType type; // The type of reminder (pet routine, check-up, vaccine schedule)
  final DateTime dateTime; // The date and time for the reminder

  Reminder({
    required this.name,
    required this.type,
    required this.dateTime,
  });
}
