import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/adoption_form_repository.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/adoption_form.dart';

class AdoptionFormApp extends StatelessWidget {
  final String petId;

  AdoptionFormApp({required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionBloc(AdoptionFormRepository()),
      child: AdoptionForm(petId: petId),
    );
  }
}

class AdoptionForm extends StatefulWidget {
  final String petId;

  AdoptionForm({required this.petId});

  @override
  _AdoptionFormState createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<AdoptionForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _city = '';
  String _zipCode = '';
  String _residenceType = 'Apartment';
  String _ownRent = 'Own'; // Change to String
  bool _landlordAllowsPets = false;
  bool _ownedPetsBefore = false;
  List<String> _petTypesOwned = []; // Change to List<String>
  String _petPreference = 'Dog';
  String _preferredSize = '';
  String _agePreference = 'Puppy/Kitten';
  int _hoursAlone = 0; // Change to int
  String _activityLevel = 'Very Active';
  List<int> _childrenAges = []; // Change to List<int>
  String _carePlan = '';
  String _whatIfNoLongerKeep = '';
  bool _longTermCommitment = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoption Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adoption Form'),
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 400,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 2.0),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Personal Information'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextFormField('Full Name', (value) => _fullName = value),
                            _buildTextFormField('Email Address', (value) => _email = value),
                            _buildTextFormField('Phone Number', (value) => _phone = value, isNumeric: true),
                            _buildTextFormField('Address', (value) => _address = value),
                            _buildTextFormField('City', (value) => _city = value),
                            _buildTextFormField('Zip Code', (value) => _zipCode = value, isNumeric: true),
                          ],
                        ),
                      ),
                      _buildSectionTitle('Living Situation'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDropdownFormField(
                              'Type of Residence',
                              ['Apartment', 'House'],
                                  (value) => setState(() => _residenceType = value!),
                              _residenceType,
                            ),
                            _buildDropdownFormField(
                              'Own or Rent?',
                              ['Own', 'Rent'], // Change to Dropdown
                                  (value) => setState(() => _ownRent = value!),
                              _ownRent,
                            ),
                            if (_ownRent == 'Rent') ...[
                              Text('Does your landlord allow pets?'),
                              Row(
                                children: [
                                  Radio(
                                    value: true,
                                    groupValue: _landlordAllowsPets,
                                    onChanged: (value) => setState(() => _landlordAllowsPets = true),
                                  ),
                                  Text('Yes'),
                                  Radio(
                                    value: false,
                                    groupValue: _landlordAllowsPets,
                                    onChanged: (value) => setState(() => _landlordAllowsPets = false),
                                  ),
                                  Text('No'),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      _buildSectionTitle('Pet Experience'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _ownedPetsBefore,
                                  onChanged: (value) => setState(() => _ownedPetsBefore = value!),
                                ),
                                Text('Have you owned pets before?'),
                              ],
                            ),
                            if (_ownedPetsBefore)
                              _buildTextFormField(
                                'What types of pets have you owned? (comma-separated)',
                                    (value) {
                                  setState(() {
                                    _petTypesOwned = value.split(',').map((e) => e.trim()).toList();
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                      _buildSectionTitle('Pet Preferences'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDropdownFormField(
                              'What type of pet are you interested in adopting?',
                              ['Dog', 'Cat'],
                                  (value) => setState(() => _petPreference = value!),
                              _petPreference,
                            ),
                            _buildTextFormField('Preferred Size or Breed', (value) => _preferredSize = value),
                            _buildDropdownFormField(
                              'Age Preference',
                              ['Puppy/Kitten', 'Adult', 'Senior'],
                                  (value) => setState(() => _agePreference = value!),
                              _agePreference,
                            ),
                          ],
                        ),
                      ),
                      _buildSectionTitle('Lifestyle and Activity Level'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextFormField(
                              'How many hours will the pet be left alone during the day?',
                                  (value) {
                                setState(() {
                                  _hoursAlone = int.tryParse(value) ?? 0; // Ensure it's an int
                                });
                              },
                              isNumeric: true,
                            ),
                            _buildDropdownFormField(
                              'How active is your household?',
                              ['Very Active', 'Moderately Active', 'Low Activity'],
                                  (value) => setState(() => _activityLevel = value!),
                              _activityLevel,
                            ),
                            _buildTextFormField(
                              'If you have children, what are their ages? (comma-separated)',
                                  (value) {
                                setState(() {
                                  _childrenAges = value.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      _buildSectionTitle('Care and Commitment'),
                      _buildBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextFormField(
                              'How do you plan to care for the pet?',
                                  (value) => _carePlan = value,
                            ),
                            _buildTextFormField(
                              'What will you do if you can no longer keep the pet?',
                                  (value) => _whatIfNoLongerKeep = value,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _longTermCommitment,
                                  onChanged: (value) => setState(() => _longTermCommitment = value!),
                                ),
                                Expanded(
                                  child: Text(
                                    'Can you commit to a pet long-term?',
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildSubmitButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBox(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  Widget _buildTextFormField(String label, Function(String) onSaved, {bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
      onSaved: (value) => onSaved(value!),
    );
  }

  Widget _buildDropdownFormField(String label, List<String> options, Function(String?) onChanged, String currentValue) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: currentValue,
      onChanged: onChanged,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocConsumer<AdoptionBloc, AdoptionState>(
      listener: (context, state) {
        if (state is AdoptionSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted successfully!')));
          _formKey.currentState!.reset(); // Reset the form after submission
        } else if (state is AdoptionError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Create the adoption form model from input values
              _formKey.currentState!.save();

              final adoptionForm = AdoptionFormModel(
                petId: widget.petId,
                fullName: _fullName,
                email: _email,
                phone: _phone,
                address: _address,
                city: _city,
                zipCode: _zipCode,
                residenceType: _residenceType,
                ownRent: _ownRent,
                landlordAllowsPets: _landlordAllowsPets,
                ownedPetsBefore: _ownedPetsBefore,
                petTypesOwned: _petTypesOwned,
                petPreference: _petPreference,
                preferredSize: _preferredSize,
                agePreference: _agePreference,
                hoursAlone: _hoursAlone,
                activityLevel: _activityLevel,
                childrenAges: _childrenAges,
                carePlan: _carePlan,
                whatIfNoLongerKeep: _whatIfNoLongerKeep,
                longTermCommitment: _longTermCommitment,
              );

              // Dispatch the SubmitAdoptionForm event
              context.read<AdoptionBloc>().add(SubmitAdoptionForm(adoptionForm));
            }
          },
          child: state is AdoptionSubmitting ? CircularProgressIndicator() : Text('Submit'),
        );
      },
    );
  }
}
