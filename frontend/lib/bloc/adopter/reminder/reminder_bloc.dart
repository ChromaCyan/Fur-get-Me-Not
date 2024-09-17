// blocs/reminder_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';
import 'package:fur_get_me_not/models/reminder.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderLoading()) {
    // Handle LoadReminders event
    on<LoadReminders>((event, emit) {
      // Dummy data for now
      final dummyReminders = [
        Reminder(
          name: 'Feed the Pet',
          type: ReminderType.petRoutine,
          dateTime: DateTime.now().add(Duration(hours: 2)),
        ),
        Reminder(
          name: 'Vet Check-up',
          type: ReminderType.checkUp,
          dateTime: DateTime.now().add(Duration(days: 1)),
        ),
        Reminder(
          name: 'Vaccination',
          type: ReminderType.vaccineSchedule,
          dateTime: DateTime.now().add(Duration(days: 7)),
        ),
      ];

      emit(ReminderLoaded(dummyReminders));
    });

    // Handle AddReminder event
    on<AddReminder>((event, emit) {
      if (state is ReminderLoaded) {
        final loadedState = state as ReminderLoaded;
        final updatedReminders = List<Reminder>.from(loadedState.reminders)
          ..add(event.reminder);
        emit(ReminderLoaded(updatedReminders));
      }
    });
  }
}
