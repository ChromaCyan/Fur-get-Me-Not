// // blocs/reminder_event.dart
// import 'package:equatable/equatable.dart';
// import 'package:fur_get_me_not/adopter/models/reminder/reminder.dart';

// abstract class ReminderEvent extends Equatable {
//   const ReminderEvent();

//   @override
//   List<Object?> get props => [];
// }

// // Event to load the list of reminders
// class LoadReminders extends ReminderEvent {}

// // Event to add a new reminder
// class AddReminder extends ReminderEvent {
//   final Reminder reminder;

//   const AddReminder(this.reminder);

//   @override
//   List<Object?> get props => [reminder];
// }

// // Event to update an existing reminder
// class UpdateReminder extends ReminderEvent {
//   final Reminder reminder;

//   const UpdateReminder(this.reminder);

//   @override
//   List<Object?> get props => [reminder];
// }

// // Event to delete a reminder
// class DeleteReminder extends ReminderEvent {
//   final String id;

//   const DeleteReminder(this.id);

//   @override
//   List<Object?> get props => [id];
// }
