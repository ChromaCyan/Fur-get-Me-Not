import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_event.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_state.dart';
import 'package:fur_get_me_not/models/reminder.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadReminders event
    BlocProvider.of<ReminderBloc>(context).add(LoadReminders());

    return Scaffold(
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state is ReminderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ReminderLoaded) {
            final reminders = state.reminders;
            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return ListTile(
                  title: Text(reminder.title),
                  subtitle: Text(reminder.reminderDate.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/update_reminder',
                              arguments: reminder);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<ReminderBloc>()
                              .add(DeleteReminder(reminder.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ReminderError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No reminders found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_reminder');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
