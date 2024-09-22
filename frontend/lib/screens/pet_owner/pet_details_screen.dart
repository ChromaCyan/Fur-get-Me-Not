import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/models/pet.dart';
import 'package:fur_get_me_not/models/const.dart';
import 'package:fur_get_me_not/screens/shared/chat_screen.dart';
import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_event.dart';
import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_state.dart';
import 'package:fur_get_me_not/repositories/pet_repository.dart';

class PetsDetailPage extends StatelessWidget {
  final String petId;

  const PetsDetailPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Use BlocProvider to provide the PetDetailsBloc
    return BlocProvider(
      create: (context) => PetDetailsBloc(
        petRepository: context.read<PetRepository>(),
      )..add(LoadPetDetailsEvent(petId: petId)), // Trigger the loading of pet details
      child: Scaffold(
        body: BlocBuilder<PetDetailsBloc, PetDetailsState>(
          builder: (context, state) {
            if (state is PetDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PetDetailsLoaded) {
              return buildPetDetailsPage(context, state.pet, size);
            } else if (state is PetDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container(); // Fallback if no valid state is provided
          },
        ),
      ),
    );
  }

  Widget buildPetDetailsPage(BuildContext context, Pet pet, Size size) {
    bool showPetInfo = true;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          itemsImageAndBackground(size, pet.petImageUrl),
          backButton(size, context),
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
                      nameAddressAndFavoriteButton(context, pet),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          moreInfo(color1, color1.withOpacity(0.5), pet.gender, "Gender"),
                          moreInfo(color2, color2.withOpacity(0.5), pet.breed, "Breed"),
                          moreInfo(color2, color2.withOpacity(0.5), "${pet.age} Years", "Age"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ownerInfo(context, pet),
                      const SizedBox(height: 20),
                      toggleInfoButtons(context, showPetInfo, pet),
                      const SizedBox(height: 20),
                      adoptMeButton(),
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

  Widget toggleInfoButtons(BuildContext context, bool showPetInfo, Pet pet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<PetDetailsBloc>().add(LoadPetDetailsEvent(petId: pet.id)); // Load pet info
            showPetInfo = true;
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(showPetInfo ? Colors.blue : Colors.grey),
          ),
          child: const Text('Pet Info'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<PetDetailsBloc>().add(LoadPetDetailsEvent(petId: pet.id)); // Load medical history
            showPetInfo = false;
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(showPetInfo ? Colors.grey : Colors.blue),
          ),
          child: const Text('Vaccine/Medical History'),
        ),
      ],
    );
  }

  Widget itemsImageAndBackground(Size size, String petImageUrl) {
    return Container(
      height: size.height * 0.50,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Hero(
              tag: petImageUrl,
              child: Image.network(
                petImageUrl,
                height: size.height * 0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned backButton(Size size, BuildContext context) {
    return Positioned(
      height: size.height * 0.14,
      right: 20,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget adoptMeButton() {
    return Container(
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
    );
  }

  Widget nameAddressAndFavoriteButton(BuildContext context, Pet pet) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: () {
            // Handle edit action
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<PetDetailsBloc>().add(UpdatePetDetailsEvent(pet: pet));
          },
        ),
      ],
    );
  }

  Widget ownerInfo(BuildContext context, Pet pet) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: pet.gender == 'Male' ? Colors.blue : Colors.pink,
          backgroundImage: const AssetImage('images/image2.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sophia Black',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.chat_outlined,
              color: Colors.lightBlue,
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  ClipRRect moreInfo(Color pawColor, Color backgroundColor, String title, String value) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: 0,
            child: Transform.rotate(
              angle: 12,
              child: Image.asset(
                'images/pet-cat2.png',
                color: Colors.black,
                height: 55,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
