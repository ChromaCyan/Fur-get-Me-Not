import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_event.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_state.dart';
import 'package:fur_get_me_not/models/reminder.dart';

class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
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
                  title: Text(reminder.name),
                  subtitle: Text(reminder.dateTime.toString()),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load reminders.'));
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
