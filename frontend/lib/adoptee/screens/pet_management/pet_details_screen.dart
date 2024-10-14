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
  late ScrollController _scrollController;
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          // Background with parallax effect
          itemsImageAndBackground(size),

          // Content with scrolling
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.5, // Image height
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: size.height * 0.86,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            nameAddressAndFavoriteButton(),
                            const SizedBox(height: 20),
                            buildToggleButtons(),
                            const SizedBox(height: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  showPetInfo
                                      ? PetInfoWidget(pet: widget.pet)
                                      : showVaccineHistory
                                          ? VaccineHistoryWidget(
                                              vaccineHistory:
                                                  widget.pet.vaccineHistory)
                                          : MedicalHistoryWidget(
                                              medicalHistory:
                                                  widget.pet.medicalHistory),
                                  const SizedBox(height: 20),
                                  buildEditDeleteButtons(context),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2), // Shadow effect
                  ),
                ],
              ),
              child: BackButtonWidget(
                // Custom back button widget
                color: Colors.black,
                iconSize: 24.0,
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
            Text(
              widget.pet.breed,
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
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

  // Parallax effect on image background
  // Static image background
  Container itemsImageAndBackground(Size size) {
    return Container(
      height: size.height * 0.5, // Static image height
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Hero(
        tag: widget.pet.petImageUrl,
        child: Image.network(
          widget.pet.petImageUrl,
          height: size.height * 0.5, // Static image height
          fit: BoxFit.cover,
        ),
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
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Edit', style: TextStyle(fontSize: 16)),
        ),
        ElevatedButton(
          onPressed: () {
            _deletePet(context, widget.pet.id ?? '');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Delete', style: TextStyle(fontSize: 16)),
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
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<PetManagementBloc>()
                    .add(RemovePetEvent(petId: petId));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pet deleted successfully')),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdopteeHomeScreen()),
                  (Route<dynamic> route) => false,
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
