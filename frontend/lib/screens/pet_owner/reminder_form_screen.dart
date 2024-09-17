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
  String _name = '';
  ReminderType _type = ReminderType.petRoutine;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Reminder Name'),
                onSaved: (value) => _name = value!,
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              DropdownButtonFormField<ReminderType>(
                value: _type,
                decoration: InputDecoration(labelText: 'Reminder Type'),
                items: ReminderType.values.map((ReminderType type) {
                  return DropdownMenuItem<ReminderType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _type = value!),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newReminder = Reminder(
                      name: _name,
                      type: _type,
                      dateTime: _selectedDate,
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
