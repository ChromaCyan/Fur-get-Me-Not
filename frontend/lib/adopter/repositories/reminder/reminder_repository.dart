// import 'package:fur_get_me_not/adopter/models/reminder/reminder.dart';

// class ReminderRepository {
//   final List<Reminder> _reminders = [
//     Reminder(
//       id: '1',
//       title: 'Vet Appointment',
//       description: 'Annual check-up for Buddy.',
//       reminderDate: DateTime.now().add(Duration(days: 1)),
//       repeat: false,
//     ),
//     Reminder(
//       id: '2',
//       title: 'Grooming',
//       description: 'Monthly grooming session for Whiskers.',
//       reminderDate: DateTime.now().add(Duration(days: 7)),
//       repeat: true,
//     ),
//   ];

//   Future<List<Reminder>> getReminders() async {
//     await Future.delayed(Duration(seconds: 1));
//     return _reminders;
//   }

//   Future<Reminder> addReminder(Reminder reminder) async {
//     await Future.delayed(Duration(seconds: 1));
//     _reminders.add(reminder);
//     return reminder;
//   }

//   Future<Reminder> updateReminder(Reminder updatedReminder) async {
//     await Future.delayed(Duration(seconds: 1));
//     final index = _reminders.indexWhere((r) => r.id == updatedReminder.id);
//     if (index != -1) {
//       _reminders[index] = updatedReminder;
//       return updatedReminder;
//     } else {
//       throw Exception('Reminder not found');
//     }
//   }

//   Future<void> deleteReminder(String id) async {
//     await Future.delayed(Duration(seconds: 1));
//     _reminders.removeWhere((r) => r.id == id);
//   }
// }
