import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPetForm extends StatefulWidget {
  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  File? _medicalHistoryFile;
  File? _vaccinationRecordsFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (type == 'medical') {
          _medicalHistoryFile = File(pickedFile.path);
        } else if (type == 'vaccination') {
          _vaccinationRecordsFile = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(labelText: 'Breed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the breed';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Medical History'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickFile('medical'),
                    child: Text('Upload File/Image'),
                  ),
                  if (_medicalHistoryFile != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('File selected: ${_medicalHistoryFile!.path.split('/').last}'),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text('Vaccination Records'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickFile('vaccination'),
                    child: Text('Upload File/Image'),
                  ),
                  if (_vaccinationRecordsFile != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('File selected: ${_vaccinationRecordsFile!.path.split('/').last}'),
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final petName = _nameController.text;
                    final age = _ageController.text;
                    final breed = _breedController.text;

                    // Handle form submission
                    print('Pet Name: $petName');
                    print('Age: $age');
                    print('Breed: $breed');
                    if (_medicalHistoryFile != null) {
                      print('Medical History File: ${_medicalHistoryFile!.path}');
                    }
                    if (_vaccinationRecordsFile != null) {
                      print('Vaccination Records File: ${_vaccinationRecordsFile!.path}');
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pet added successfully')),
                    );

                    // Optionally clear the form
                    _nameController.clear();
                    _ageController.clear();
                    _breedController.clear();
                    setState(() {
                      _medicalHistoryFile = null;
                      _vaccinationRecordsFile = null;
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
