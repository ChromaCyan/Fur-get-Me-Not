import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_event.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_state.dart';
import 'package:fur_get_me_not/models/reminder.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _selectedDate = DateTime.now();
  bool _repeat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text('Select Date: ${_selectedDate.toLocal()}'),
              ),
              CheckboxListTile(
                title: Text('Repeat'),
                value: _repeat,
                onChanged: (bool? value) {
                  setState(() {
                    _repeat = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newReminder = Reminder(
                      id: DateTime.now().toString(), // Generate a new ID
                      title: _title,
                      description: _description,
                      reminderDate: _selectedDate,
                      repeat: _repeat,
                    );
                    BlocProvider.of<ReminderBloc>(context)
                        .add(AddReminder(newReminder));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
