import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_details/pet_details_event.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_details/pet_details_state.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_event.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adoptee/screens/home_screen.dart';
import 'package:fur_get_me_not/widgets/buttons/back_button.dart';
import 'package:fur_get_me_not/widgets/admin_pet_details/medical_card.dart';
import 'package:fur_get_me_not/widgets/admin_pet_details/vaccine_card.dart';
import 'package:fur_get_me_not/widgets/admin_pet_details/pet_info.dart';
import 'package:fur_get_me_not/widgets/pet_details/toggle_button.dart';
import 'package:fur_get_me_not/adoptee/screens/pet_management/edit_pet_form.dart';

class PetDetailsPage extends StatelessWidget {
  final String petId;

  const PetDetailsPage({Key? key, required this.petId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petDetailsBloc = BlocProvider.of<AdopteePetDetailsBloc>(context);
    petDetailsBloc.add(LoadPetDetailsEvent(petId: petId));

    return Scaffold(
      body: BlocBuilder<AdopteePetDetailsBloc, PetDetailsState>(
        builder: (context, state) {
          if (state is PetDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetDetailsLoaded) {
            final pet = state.pet;
            return _PetDetailsView(pet: pet);
          } else if (state is PetDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

class _PetDetailsView extends StatefulWidget {
  final AdminPet pet;

  const _PetDetailsView({Key? key, required this.pet}) : super(key: key);

  @override
  State<_PetDetailsView> createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<_PetDetailsView> {
  bool showPetInfo = true;
  bool showVaccineHistory = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          itemsImageAndBackground(size),
          Column(
            children: [
              const SizedBox(
                  height: 40), // Add space here to lower the BackButtonWidget
              BackButtonWidget(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.52,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      nameAddressAndFavoriteButton(),
                      const SizedBox(height: 20),
                      buildToggleButtons(),
                      const SizedBox(height: 20),
                      showPetInfo
                          ? PetInfoWidget(pet: widget.pet)
                          : showVaccineHistory
                              ? VaccineHistoryWidget(
                                  vaccineHistory: widget.pet.vaccineHistory)
                              : MedicalHistoryWidget(
                                  medicalHistory: widget.pet.medicalHistory),
                      const SizedBox(height: 20),
                      buildEditDeleteButtons(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameAddressAndFavoriteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.pet.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ToggleButton(
          label: 'Pet Info',
          isSelected: showPetInfo,
          onPressed: () {
            setState(() {
              showPetInfo = true;
              showVaccineHistory = false;
            });
          },
        ),
        ToggleButton(
          label: 'Vaccine History',
          isSelected: showVaccineHistory,
          onPressed: () {
            setState(() {
              showPetInfo = false;
              showVaccineHistory = true;
            });
          },
        ),
        ToggleButton(
          label: 'Medical History',
          isSelected: !showPetInfo && !showVaccineHistory,
          onPressed: () {
            setState(() {
              showPetInfo = false;
              showVaccineHistory = false;
            });
          },
        ),
      ],
    );
  }

  Container itemsImageAndBackground(Size size) {
    return Container(
      height: size.height * 0.50,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -60,
            top: 30,
            child: Transform.rotate(
              angle: -11.5,
              child: Image.asset(
                'images/pet-cat2.png',
                color: Colors.black,
                height: 55,
              ),
            ),
          ),
          Positioned(
            right: -60,
            bottom: 0,
            child: Transform.rotate(
              angle: 12,
              child: Image.asset(
                'images/pet-cat2.png',
                color: Colors.black,
                height: 55,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Hero(
              tag: widget.pet.petImageUrl,
              child: Image.network(
                widget.pet.petImageUrl,
                height: size.height * 0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditDeleteButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPetForm(pet: widget.pet),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Background color for Edit button
            foregroundColor: Colors.white, // Text color for Edit button
            padding: const EdgeInsets.symmetric(
                horizontal: 50, vertical: 12), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          child:
              const Text('Edit', style: TextStyle(fontSize: 16)), // Text style
        ),
        ElevatedButton(
          onPressed: () {
            _deletePet(context, widget.pet.id ?? '');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Background color for Delete button
            foregroundColor: Colors.white, // Text color for Delete button
            padding: const EdgeInsets.symmetric(
                horizontal: 50, vertical: 12), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          child: const Text('Delete',
              style: TextStyle(fontSize: 16)), // Text style
        ),
      ],
    );
  }

  void _deletePet(BuildContext context, String petId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this pet?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Trigger pet deletion
                context
                    .read<PetManagementBloc>()
                    .add(RemovePetEvent(petId: petId));

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pet deleted successfully')),
                );

                // Navigate to home screen after deletion
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdopteeHomeScreen()),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
