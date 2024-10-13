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
    // Use the bloc
    final petDetailsBloc = BlocProvider.of<PetDetailsBloc>(context);
    // Dispatch an event to load pet details
    petDetailsBloc.add(LoadPetDetailsEvent(petId: petId));

    return Scaffold(
      body: BlocBuilder<PetDetailsBloc, PetDetailsState>(
        builder: (context, state) {
          if (state is PetDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetDetailsLoaded) {
            final pet = state.pet;
            return _PetDetailsView(pet: pet); // Your custom view widget
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

  const _PetDetailsView({Key? key, required this.pet,}) : super(key: key);

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
          BackButtonWidget(),
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
                      OwnerInfo(
                        firstName: widget.pet.adoptee.firstName,
                        lastName: widget.pet.adoptee.lastName,
                        gender: widget.pet.gender,
                        profileImageUrl: 'images/image2.png',
                        chatId: widget.pet.adoptee.chatId,
                        otherUserId: widget.pet.adoptee.id,
                      ),
                      const SizedBox(height: 20),
                      buildToggleButtons(),
                      const SizedBox(height: 20),
                      showPetInfo
                          ? PetInfoWidget(pet: widget.pet)
                          : showVaccineHistory
                          ? VaccineHistoryWidget(vaccineHistory: widget.pet.vaccineHistory)
                          : MedicalHistoryWidget(medicalHistory: widget.pet.medicalHistory),
                      const SizedBox(height: 20),
                      adoptMeButton(context),
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
            // const Text(
            //   "Address or location",
            //   style: TextStyle(fontSize: 16, color: Colors.grey),
            // ),
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

  Widget adoptMeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the AdoptionForm with the petId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdoptionForm(petId: widget.pet.id),
          ),
        );
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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

  ClipRRect moreInfo(Color pawColor, Color backgroundColor, String title, String value) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
            ),
          ),
          Container(
            height: 60,
            width: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
