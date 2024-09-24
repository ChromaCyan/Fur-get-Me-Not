// blocs/reminder_state.dart
import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/models/adopters/reminder/reminder.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderLoading extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<Reminder> reminders;

  const ReminderLoaded(this.reminders);

  @override
  List<Object?> get props => [reminders];
}

class ReminderError extends ReminderState {
  final String message;

  const ReminderError(this.message);

  @override
  List<Object?> get props => [message];
}
