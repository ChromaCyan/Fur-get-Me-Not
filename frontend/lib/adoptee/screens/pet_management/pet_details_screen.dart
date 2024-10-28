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
            return _PetDetailsView(pet: pet); // Use new layout
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
          itemsImageAndBackground(size),

          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.5,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: size.height * 0.52,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5E6CA),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              nameAddressAndFavoriteButton(),
                              const SizedBox(height: 15),
                              
                              const Text(
                                'Pet Info',
                                style: TextStyle(
                                  fontSize: 20, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              PetInfoWidget(pet: widget.pet), // Always display PetInfo
                              const SizedBox(height: 20),

                              buildToggleButtons(),
                              const SizedBox(height: 50),
                            ],
                          ),
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
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BackButtonWidget(
                onPressed: () => Navigator.of(context).pop(),
                iconSize: 30.0,
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
              style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        buildEditDeleteButtons(context), // Add buttons here
      ],
    );
  }

  Widget buildEditDeleteButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange), // Edit icon
          tooltip: 'Edit Pet',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPetForm(pet: widget.pet),
              ),
            );
          },
        ),

        IconButton(
        icon: const Icon(Icons.delete, color: Colors.red), // Delete icon
        tooltip: 'Delete Pet',
        onPressed: () {
          _deletePet(context, widget.pet.id ?? '');
        },
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

  Widget buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
            backgroundColor: const Color(0xFF21899C),
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            // Show vaccine history dialog
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        VaccineHistoryWidget(vaccineHistory: widget.pet.vaccineHistory),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close', style: TextStyle(color: Colors.red))
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Vaccine History', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
            backgroundColor: const Color(0xFF21899C),
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            // Show medical history dialog
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MedicalHistoryWidget(medicalHistory: widget.pet.medicalHistory),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Medical History', style: TextStyle(color: Colors.white)),
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
      child: Hero(
        tag: widget.pet.petImageUrl,
        child: Image.network(
          widget.pet.petImageUrl,
          height: size.height * 0.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


