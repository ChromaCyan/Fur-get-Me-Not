import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/const.dart';
import 'package:fur_get_me_not/models/pet.dart';
import 'package:readmore/readmore.dart';
import 'package:fur_get_me_not/screens/shared/chat_screen.dart';
import 'package:fur_get_me_not/screens/pet_owner/adoption_form.dart';

class PetsDetailPage extends StatefulWidget {
  final Pet pet;
  const PetsDetailPage({super.key, required this.pet});

  @override
  State<PetsDetailPage> createState() => _PetsDetailPageState();
}

class _PetsDetailPageState extends State<PetsDetailPage> {
  bool showPetInfo = true; // To toggle between pet info and vaccine/medical history

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              itemsImageAndBackground(size),
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
                          nameAddressAndFavoriteButton(),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              moreInfo(
                                color1,
                                color1.withOpacity(0.5),
                                widget.pet.gender,
                                "Gender",
                              ),
                              moreInfo(
                                color2,
                                color2.withOpacity(0.5),
                                "${widget.pet.breed}",
                                "Breed",
                              ),
                              moreInfo(
                                color2,
                                color2.withOpacity(0.5),
                                "${widget.pet.age} Years",
                                "Age",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ownerInfo(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showPetInfo = true;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    showPetInfo ? Colors.blue : Colors.grey,
                                  ),
                                ),
                                child: const Text('Pet Info'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showPetInfo = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    showPetInfo ? Colors.grey : Colors.blue,
                                  ),
                                ),
                                child: const Text('Vaccine/Medical History'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          showPetInfo ? petInfo() : vaccineMedicalHistory(),
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
        ));
  }

  Widget petInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: ${widget.pet.name}"),
        Text("Age: ${widget.pet.age} years old"),
        Text("Breed: ${widget.pet.breed}"),
        Text("Height: ${widget.pet.height} cm"),
        Text("Weight: ${widget.pet.weight} kg"),
        Text("Special Care: ${widget.pet.specialCareInstructions}"),
      ],
    );
  }

  Widget vaccineMedicalHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(widget.pet.vaccineHistoryImageUrl),
        const SizedBox(height: 10),
        Image.network(widget.pet.medicalHistoryImageUrl),
      ],
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

  Row ownerInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: widget.pet.gender == 'Male' ? Colors.blue : Colors.pink,
          backgroundImage: const AssetImage('images/image2.png'), // Replace with actual owner image
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sophia Black', // Placeholder name, replace with actual owner name if available
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
            // Handle chat action
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

  Row nameAddressAndFavoriteButton() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pet.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // Handle edit action
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Handle delete action
              },
            ),
          ],
        ),
      ],
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
                'images/pet-cat2.png',  // path to the local image asset
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
                'images/pet-cat2.png',  // path to the local image asset
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

  ClipRRect moreInfo(Color pawColor, Color backgroundColr, String title, String value) {
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
                'images/pet-cat2.png',  // path to the local image asset
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
              color: backgroundColr,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}