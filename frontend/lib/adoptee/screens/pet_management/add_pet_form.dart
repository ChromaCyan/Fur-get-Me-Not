import 'package:flutter/material.dart';
import 'package:fur_get_me_not/widgets/headers/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fur_get_me_not/widgets/forms/form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_event.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';

class AddPetForm extends StatefulWidget {
  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController specialCareController = TextEditingController();

  // Controllers for medical history
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController diagnosisDateController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController veterinarianNameController =
      TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController treatmentDateController = TextEditingController();
  final TextEditingController recoveryStatusController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Controllers for vaccine history
  final TextEditingController vaccineNameController = TextEditingController();
  final TextEditingController vaccinationDateController =
      TextEditingController();
  final TextEditingController nextDueDateController = TextEditingController();

  String? selectedGender;
  bool _isLoading = false;

  String? selectedRecoveryStatus;

  final ImagePicker _picker = ImagePicker();
  File? _selectedPetImage;

  Future<void> _selectAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedPetImage = File(image.path);
      });
    } else {
      print('No image selected');
    }
  }

  // Show date picker and set the selected date in the controller
  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text =
          '${picked.toLocal()}'.split(' ')[0]; // Format date to YYYY-MM-DD
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Upload the image and get the URL
        String imageUrl =
            await AdminPetRepository().uploadImage(_selectedPetImage!);
        print('Image URL obtained: $imageUrl'); // Debugging line

        // Create a new MedicalHistory instance
        final medicalHistory = MedicalHistory(
          condition: conditionController.text,
          diagnosisDate: DateTime.parse(diagnosisDateController.text),
          treatment: treatmentController.text,
          veterinarianName: veterinarianNameController.text,
          clinicName: clinicNameController.text,
          treatmentDate: treatmentDateController.text.isNotEmpty
              ? DateTime.parse(treatmentDateController.text)
              : null,
          recoveryStatus: selectedRecoveryStatus ?? 'Unknown',
          notes: notesController.text,
        );

        // Create a new VaccineHistory instance
        final vaccineHistory = VaccineHistory(
          vaccineName: vaccineNameController.text,
          vaccinationDate: DateTime.parse(vaccinationDateController.text),
          nextDueDate: nextDueDateController.text.isNotEmpty
              ? DateTime.parse(nextDueDateController.text)
              : null,
          veterinarianName: veterinarianNameController.text,
          clinicName: clinicNameController.text,
          notes: notesController.text,
        );

        // Create a new pet object
        final newPet = AdminPet(
          name: petNameController.text,
          breed: breedController.text,
          gender: selectedGender!,
          age: int.parse(ageController.text),
          height: double.tryParse(heightController.text) ?? 0.0,
          weight: double.tryParse(weightController.text) ?? 0.0,
          petImageUrl: imageUrl,
          description: descriptionController.text,
          specialCareInstructions: specialCareController.text,
          adoptee: Adoptee(id: '', firstName: '', lastName: ''),
          medicalHistory: medicalHistory,
          vaccineHistory: vaccineHistory,
          status: 'available',
        );

        context
            .read<PetManagementBloc>()
            .add(AddPetEvent(pet: newPet, image: _selectedPetImage!));

        Navigator.pop(context);
      } catch (e) {
        print('Error while adding pet: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF21899C))),
      ),
    );
  }

  Widget _buildBox(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF21899C).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xFFFE9879).withOpacity(0.2),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add a pet for adoption',
        hasBackButton: true,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet details
                _buildSectionTitle('🐶 Pet Information'),
                _buildBox(
                  Column(
                    children: [
                      // Container for displaying or uploading the image
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _selectedPetImage == null
                            ? IconButton(
                                icon: Icon(Icons.add_a_photo,
                                    size: 40, color: Colors.grey[600]),
                                onPressed: _selectAndUploadImage,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedPetImage!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),

                      SizedBox(height: 16),

                      // Improved button for image upload
                      ElevatedButton.icon(
                        onPressed: _selectAndUploadImage,
                        icon: Icon(Icons.upload_file, color: Colors.white),
                        label: Text(
                          _selectedPetImage != null
                              ? 'Change Pet Image'
                              : 'Add Pet Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: petNameController,
                        labelText: 'Pet Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the pet name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: breedController,
                        labelText: 'Breed',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the breed';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      CustomDropdownFormField(
                        labelText: 'Gender',
                        value: selectedGender,
                        items: ['Male', 'Female'],
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

                      CustomTextFormField(
                        controller: ageController,
                        labelText: 'Age',
                        keyboardType: TextInputType.number,
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

                      CustomTextFormField(
                        controller: heightController,
                        labelText: 'Height',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the height';
                          }
                          if (num.tryParse(value) == null) {
                            return 'Height must be a number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: weightController,
                        labelText: 'Weight',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the weight';
                          }
                          if (num.tryParse(value) == null) {
                            return 'Weight must be a number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: descriptionController,
                        labelText: 'Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                _buildSectionTitle('🏥 Medical History'),
                _buildBox(
                  Column(
                    children: [
                      // Medical History
                      Text('Medical History',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextFormField(
                        controller: conditionController,
                        labelText: 'Condition',
                      ),
                      SizedBox(height: 8),

                      // Use a TextFormField that opens a date picker
                      GestureDetector(
                        onTap: () => _selectDate(diagnosisDateController),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: diagnosisDateController,
                            labelText: 'Diagnosis Date',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a diagnosis date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      CustomTextFormField(
                        controller: treatmentController,
                        labelText: 'Treatment',
                      ),
                      SizedBox(height: 8),

                      CustomTextFormField(
                        controller: veterinarianNameController,
                        labelText: 'Veterinarian Name',
                      ),
                      SizedBox(height: 8),

                      CustomTextFormField(
                        controller: clinicNameController,
                        labelText: 'Clinic Name',
                      ),
                      SizedBox(height: 8),

                      // Use a TextFormField that opens a date picker
                      GestureDetector(
                        onTap: () => _selectDate(treatmentDateController),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: treatmentDateController,
                            labelText: 'Treatment Date',
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      CustomDropdownFormField(
                        labelText: 'Recovery Status',
                        value: selectedRecoveryStatus,
                        items: ['Recovered', 'Ongoing Treatment', 'Chronic'],
                        onChanged: (newValue) {
                          setState(() {
                            selectedRecoveryStatus = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a recovery status';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 8),

                      CustomTextFormField(
                        controller: notesController,
                        labelText: 'Notes',
                      ),
                    ],
                  ),
                ),

                _buildSectionTitle('💉 Vaccine History'),
                _buildBox(
                  Column(
                    children: [
                      // Vaccine History
                      Text('Vaccine History',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextFormField(
                        controller: vaccineNameController,
                        labelText: 'Vaccine Name',
                      ),
                      SizedBox(height: 8),

                      // Use a TextFormField that opens a date picker
                      GestureDetector(
                        onTap: () => _selectDate(vaccinationDateController),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: vaccinationDateController,
                            labelText: 'Vaccination Date',
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Use a TextFormField that opens a date picker
                      GestureDetector(
                        onTap: () => _selectDate(nextDueDateController),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: nextDueDateController,
                            labelText: 'Next Due Date',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          backgroundColor: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                      ),
                    ),

                    SizedBox(width: 16), // Space between buttons

                    // Submit Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors
                                    .black) // Change to black for better visibility
                            : Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white), // Text color
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
