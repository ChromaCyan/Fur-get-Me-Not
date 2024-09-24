import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPetForm extends StatefulWidget {
  @override
  _AdoptFormScreenState createState() => _AdoptFormScreenState();
}

class _AdoptFormScreenState extends State<AddPetForm> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // Dropdown value for Gender
  String? selectedGender;

  // Loading state
  bool _isLoading = false;

  // Image picker
  final ImagePicker _picker = ImagePicker();
  File? _selectedPetImage;
  File? _selectedMedicalHistoryImage;
  File? _selectedVaccineHistoryImage;

  // Function to handle image selection and uploading
  Future<void> _selectAndUploadImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (type == 'pet') {
          _selectedPetImage = File(image.path);
        } else if (type == 'medical_history') {
          _selectedMedicalHistoryImage = File(image.path);
        } else if (type == 'vaccine_history') {
          _selectedVaccineHistoryImage = File(image.path);
        }
      });
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 185, 185),
        title: Text('Add a pet for adoption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet Name field
                TextFormField(
                  controller: petNameController,
                  decoration: InputDecoration(
                    labelText: 'Pet Name',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the pet name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Breed field
                TextFormField(
                  controller: breedController,
                  decoration: InputDecoration(
                    labelText: 'Breed',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the breed';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Gender Dropdown field
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select the gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Age field (Number)
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the age';
                    }
                    if (num.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Height field ( Number)
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the height';
                    }
                    if (num.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Weight field (Number)
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the weight';
                    }
                    if (num.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Image picker buttons
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _selectAndUploadImage('pet');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.yellowAccent,
                      ),
                      child: Text('Add Pet Image'),
                    ),
                    Text(_selectedPetImage != null ? '' : 'No pet image selected'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _selectAndUploadImage('medical_history');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.yellowAccent,
                      ),
                      child: Text('Add Medical History Image'),
                    ),
                    Text(_selectedMedicalHistoryImage != null ? '' : 'No medical history image selected'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _selectAndUploadImage('vaccine_history');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.yellowAccent,
                      ),
                      child: Text('Add Vaccine History Image'),
                    ),
                    Text(_selectedVaccineHistoryImage != null ? '' : 'No vaccine history image selected'),
                    SizedBox(height: 16),
                  ],
                ),
                SizedBox(height: 32),

                // Action Buttons (Cancel and Submit)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel button
                    TextButton(
                      onPressed: () {
                        // Handle cancel
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.grey[400],
                      ),
                      child: Text('Cancel'),
                    ),

                    // Submit button
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          // Process form submission
                          try {
                            // Simulate a delay for form submission
                            await Future.delayed(Duration(seconds: 2));
                            // Display a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Form submitted successfully!'),
                              ),
                            );
                          } catch (e) {
                            // Display an error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error submitting form: $e'),
                              ),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.yellowAccent,
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    petNameController.dispose();
    breedController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}