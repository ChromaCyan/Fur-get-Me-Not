import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/adoption_form_repository.dart';

void main() {
  runApp(AdoptionFormApp());
}

class AdoptionFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoption Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      home: AdoptionForm(),
    );
  }
}

class AdoptionForm extends StatefulWidget {
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
  bool _ownRent = false;
  bool _landlordAllowsPets = false;
  bool _ownedPetsBefore = false;
  String _petTypesOwned = '';
  String _petPreference = 'Dog';
  String _preferredSize = '';
  String _agePreference = 'Puppy/Kitten';
  String _hoursAlone = '';
  String _activityLevel = 'Very Active';
  String _childrenAges = '';
  String _carePlan = '';
  String _whatIfNoLongerKeep = '';
  bool _longTermCommitment = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdoptionBloc(AdoptionFormRepository()),
      child: Scaffold(
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
                            Row(
                              children: [
                                Checkbox(
                                  value: _ownRent,
                                  onChanged: (value) => setState(() => _ownRent = value!),
                                ),
                                Text('Do you own or rent?'),
                              ],
                            ),
                            if (_ownRent) ...[
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
                                'What types of pets have you owned?',
                                (value) => _petTypesOwned = value,
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
                              (value) => _hoursAlone = value,
                              isNumeric: true,
                            ),
                            _buildDropdownFormField(
                              'How active is your household?',
                              ['Very Active', 'Moderately Active', 'Low Activity'],
                              (value) => setState(() => _activityLevel = value!),
                              _activityLevel,
                            ),
                            _buildTextFormField(
                              'Do you have children? If so, what are their ages?',
                              (value) => _childrenAges = value,
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
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  Widget _buildTextFormField(String label, Function(String) onChanged, {bool isEmail = false, bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        } else if (isNumeric && !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter numbers only';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownFormField(String label, List<String> items, Function(String?) onChanged, String currentValue) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: currentValue,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted successfully')));
        }
      },
      child: Text('Submit'),
    );
  }
}
