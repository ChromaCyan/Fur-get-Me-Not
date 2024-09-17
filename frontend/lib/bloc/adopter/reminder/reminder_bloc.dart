// blocs/reminder_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';
import 'package:fur_get_me_not/models/reminder.dart';
import 'package:fur_get_me_not/repositories/reminder_repository.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository reminderRepository;

  ReminderBloc(this.reminderRepository) : super(ReminderLoading()) {
    print("ReminderBloc initialized");

    on<LoadReminders>((event, emit) async {
      print("LoadReminders event received");
      try {
        final reminders = await reminderRepository.getReminders();
        print("Reminders fetched: ${reminders.length}");
        emit(ReminderLoaded(reminders));
      } catch (_) {
        print("Error loading reminders");
        emit(ReminderError("Failed to load reminders"));
      }
    });

    // Handle AddReminder event
    on<AddReminder>((event, emit) async {
      try {
        final addedReminder = await reminderRepository.addReminder(event.reminder);
        if (state is ReminderLoaded) {
          final loadedState = state as ReminderLoaded;
          final updatedReminders = List<Reminder>.from(loadedState.reminders)
            ..add(addedReminder);
          emit(ReminderLoaded(updatedReminders));
        }
      } catch (_) {
        emit(ReminderError("Failed to add reminder"));
      }
    });

    // Handle UpdateReminder event
    on<UpdateReminder>((event, emit) async {
      try {
        final updatedReminder = await reminderRepository.updateReminder(event.reminder);
        if (state is ReminderLoaded) {
          final loadedState = state as ReminderLoaded;
          final updatedReminders = loadedState.reminders.map((reminder) =>
          reminder.id == updatedReminder.id ? updatedReminder : reminder
          ).toList();
          emit(ReminderLoaded(updatedReminders));
        }
      } catch (_) {
        emit(ReminderError("Failed to update reminder"));
      }
    });

    // Handle DeleteReminder event
    on<DeleteReminder>((event, emit) async {
      try {
        await reminderRepository.deleteReminder(event.id);
        if (state is ReminderLoaded) {
          final loadedState = state as ReminderLoaded;
          final updatedReminders = loadedState.reminders.where((reminder) => reminder.id != event.id).toList();
          emit(ReminderLoaded(updatedReminders));
        }
      } catch (_) {
        emit(ReminderError("Failed to delete reminder"));
      }
    });
  }
}
