import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_details/pet_details_event.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_details/pet_details_state.dart';
import 'package:fur_get_me_not/widgets/buttons/back_button.dart';
import 'package:fur_get_me_not/widgets/pet_details/medical_card.dart';
import 'package:fur_get_me_not/widgets/pet_details/vaccine_card.dart';
import 'package:fur_get_me_not/widgets/pet_details/pet_info.dart';
import 'package:fur_get_me_not/widgets/pet_details/owner_info.dart';
import 'package:fur_get_me_not/widgets/pet_details/toggle_button.dart';
import 'adoption_form.dart';

class PetDetailsPage extends StatelessWidget {
  final String petId;

  const PetDetailsPage({Key? key, required this.petId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petDetailsBloc = BlocProvider.of<PetDetailsBloc>(context);
    petDetailsBloc.add(LoadPetDetailsEvent(petId: petId));

    return Scaffold(
      body: BlocBuilder<PetDetailsBloc, PetDetailsState>(
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
  final Pet pet;

  const _PetDetailsView({
    Key? key,
    required this.pet,
  }) : super(key: key);

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
                        // gradient: LinearGradient(
                        //   colors: [Color(0xFFFE9879), Color(0xFF21899C)],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),

                        color: Colors.white,
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
                              const SizedBox(height: 20),
                              OwnerInfo(
                                firstName: widget.pet.adoptee.firstName,
                                lastName: widget.pet.adoptee.lastName,
                                gender: widget.pet.gender,
                                profileImageUrl: 'images/image2.png',
                                chatId: widget.pet.adoptee.chatId,
                                otherUserId: widget.pet.adoptee.id,
                              ),
                              const SizedBox(height: 20),

                              // Pet Info TextButton
                              const Text(
                                'Pet Info',
                                style: TextStyle(
                                  fontSize: 20, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // PetInfoWidget displayed by default
                              PetInfoWidget(pet: widget.pet),
                              const SizedBox(height: 20),
                              
                              buildToggleButtons(),
                              const SizedBox(height: 20),
                              adoptMeButton(context),
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
          // Positioned BackButtonWidget
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
                onPressed: () =>
                    Navigator.of(context).pop(), // Ensures navigation back
                // color: Colors.black,
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16), // Adjust size
            backgroundColor: Color(0xFF21899C), // Change color
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size for dialog
                      children: [
                        VaccineHistoryWidget(vaccineHistory: widget.pet.vaccineHistory),
                        const SizedBox(height: 20), // Spacing before the button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close', style: TextStyle(color: Colors.red)), // Customize text style if needed
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
          child: const Text('Vaccine History', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16), // Adjust size
            backgroundColor: Color(0xFF21899C), // Change color
            elevation: 5,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Color(0xFFFE9879)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size for dialog
                      children: [
                        MedicalHistoryWidget(medicalHistory: widget.pet.medicalHistory),
                        const SizedBox(height: 20), // Spacing before the button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Close', style: TextStyle(color: Colors.red)), // Customize text style if needed
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

  Widget adoptMeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdoptionForm(petId: widget.pet.id),
          ),
        );
      },
      child: Center(
        child: Container(
          height: 60,
          width: 285,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: const Center(
            child: Text(
              'Adopt Me',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
