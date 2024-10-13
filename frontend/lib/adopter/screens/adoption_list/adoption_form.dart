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
  String _ownRent = 'Own';
  bool _landlordAllowsPets = false;
  bool _ownedPetsBefore = false;
  List<String> _petTypesOwned = [];
  String _petPreference = 'Dog';
  String _preferredSize = '';
  String _agePreference = 'Puppy/Kitten';
  int _hoursAlone = 0;
  String _activityLevel = 'Very Active';
  List<int> _childrenAges = [];
  String _carePlan = '';
  String _whatIfNoLongerKeep = '';
  bool _longTermCommitment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Form'),
        backgroundColor: const Color(0xFF21899C),
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
                    _buildSectionTitle('🐾 Personal Information'),
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
                    _buildSectionTitle('🏡 Living Situation'),
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
                            ['Own', 'Rent'],
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
                    _buildSectionTitle('🐶 Pet Experience'),
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
                    _buildSectionTitle('🐾 Pet Preferences'),
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
                    _buildSectionTitle('🏃 Lifestyle and Activity Level'),
                    _buildBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFormField(
                            'How many hours will the pet be left alone during the day?',
                                (value) {
                              setState(() {
                                _hoursAlone = int.tryParse(value) ?? 0;
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
                    _buildSectionTitle('📝 Care and Commitment'),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF21899C))),
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

  Widget _buildDropdownFormField(
      String label, List<String> options, Function(String?) onChanged, String currentValue) {
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _submitAdoptionForm();
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  void _submitAdoptionForm() {
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

    // Call the Bloc to submit the form
    context.read<AdoptionBloc>().add(SubmitAdoptionForm(adoptionForm));
  }
}

