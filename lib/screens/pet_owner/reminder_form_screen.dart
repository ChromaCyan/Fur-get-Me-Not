import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddReminderForm extends StatefulWidget {
  @override
  _AddReminderFormState createState() => _AddReminderFormState();
}

class _AddReminderFormState extends State<AddReminderForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Reminder Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'Select Time'
                          : _selectedTime!.format(context),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text('Pick Time'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final title = _titleController.text;
                    final description = _descriptionController.text;
                    final date = _selectedDate != null
                        ? DateFormat.yMd().format(_selectedDate!)
                        : 'No date selected';
                    final time = _selectedTime != null
                        ? _selectedTime!.format(context)
                        : 'No time selected';

                    // Handle form submission
                    print('Title: $title');
                    print('Description: $description');
                    print('Date: $date');
                    print('Time: $time');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reminder added successfully')),
                    );

                    // Optionally clear the form
                    _titleController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _selectedDate = null;
                      _selectedTime = null;
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
