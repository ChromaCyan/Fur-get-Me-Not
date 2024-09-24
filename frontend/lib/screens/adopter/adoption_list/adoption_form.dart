import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_list/adoption_form_repository.dart';

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
  String _residenceType = 'Apartment'; // Default value
  bool _ownRent = false;
  bool _landlordAllowsPets = false;
  bool _ownedPetsBefore = false;
  String _petTypesOwned = '';
  String _petPreference = 'Dog'; // Default value
  String _preferredSize = '';
  String _agePreference = 'Puppy/Kitten'; // Default value
  String _hoursAlone = '';
  String _activityLevel = 'Moderately Active'; // Default value
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
          color: Colors.red[100],
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
                child: BlocListener<AdoptionBloc, AdoptionState>(
                  listener: (context, state) {
                    if (state is AdoptionSubmitted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your adoption request has been submitted!')),
                      );
                    } else if (state is AdoptionError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
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
                              _buildTextFormField('Email Address', (value) => _email = value, isEmail: true),
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
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Dispatch the submit event with the form data
          BlocProvider.of<AdoptionBloc>(context).add(SubmitAdoptionForm(
            fullName: _fullName,
            email: _email,
            phone: _phone,
            address: _address,
            city: _city,
            zipCode: _zipCode,
            // Add other parameters as needed
          ));
        }
      },
      child: Text('Submit'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildTextFormField(String label, Function(String) onChanged, {bool isEmail = false, bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (isNumeric && !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownFormField(String label, List<String> items, Function(String?) onChanged, String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
