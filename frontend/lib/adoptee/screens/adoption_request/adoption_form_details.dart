import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_form.dart';
import 'package:fur_get_me_not/widgets/buttons/back_button.dart';

class AdoptionFormScreen extends StatelessWidget {
  final String requestId;

  AdoptionFormScreen({required this.requestId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAdoptionBloc(AdoptionRequestRepository()),
      child: AdoptionForm(requestId: requestId),
    );
  }
}

class AdoptionForm extends StatefulWidget {
  final String requestId;

  AdoptionForm({required this.requestId});

  @override
  _AdoptionFormState createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<AdoptionForm> {
  late AdminAdoptionForm _adoptionForm;

  @override
  void initState() {
    super.initState();
    _fetchAdoptionForm();
  }

  void _fetchAdoptionForm() async {
    context.read<AdminAdoptionBloc>().add(FetchAdoptionForm(widget.requestId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Form'),
        backgroundColor: const Color(0xFF21899C),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10.0, spreadRadius: 2.0),
              ],
            ),
            child: BlocBuilder<AdminAdoptionBloc, AdoptionState>(
              builder: (context, state) {
                if (state is AdoptionLoaded) {
                  _adoptionForm = state.adoptionForm;
                  return _buildForm();
                } else if (state is AdoptionError) {
                  return Center(child: Text('Error loading form: ${state.message}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('🐾 Personal Information'),
          _buildBox(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReadOnlyField('Full Name', _adoptionForm.fullName),
                _buildReadOnlyField('Email Address', _adoptionForm.email),
                _buildReadOnlyField('Phone Number', _adoptionForm.phone),
                _buildReadOnlyField('Address', _adoptionForm.address),
                _buildReadOnlyField('City', _adoptionForm.city),
                _buildReadOnlyField('Zip Code', _adoptionForm.zipCode),
              ],
            ),
          ),
          _buildSectionTitle('🏡 Living Situation'),
          _buildBox(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReadOnlyField('Type of Residence', _adoptionForm.residenceType),
                _buildReadOnlyField('Own or Rent?', _adoptionForm.ownRent),
                if (_adoptionForm.ownRent == 'Rent') ...[
                  _buildReadOnlyField('Landlord allows pets?', _adoptionForm.landlordAllowsPets ? 'Yes' : 'No'),
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
                      value: _adoptionForm.ownedPetsBefore,
                      onChanged: null, // Make it read-only
                    ),
                    Text('Have you owned pets before?'),
                  ],
                ),
                if (_adoptionForm.ownedPetsBefore)
                  _buildReadOnlyField('Types of pets owned', _adoptionForm.petTypesOwned.join(', ')),
                _buildReadOnlyField('Preferred Pet Size', _adoptionForm.preferredSize),
                _buildReadOnlyField('Age Preference', _adoptionForm.agePreference),
                _buildReadOnlyField('Activity Level', _adoptionForm.activityLevel),
                _buildReadOnlyField('Children Ages', _adoptionForm.childrenAges.join(', ')),
                _buildReadOnlyField('Care Plan', _adoptionForm.carePlan),
                _buildReadOnlyField('What if you can no longer keep the pet?', _adoptionForm.whatIfNoLongerKeep),
                _buildReadOnlyField('Long-Term Commitment', _adoptionForm.longTermCommitment ? 'Yes' : 'No'),
              ],
            ),
          ),
        ],
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

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: 400, // Set a consistent width for all fields
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF21899C)),
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xFFFE9879).withOpacity(0.3),
            ),
            child: Text(value, style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
