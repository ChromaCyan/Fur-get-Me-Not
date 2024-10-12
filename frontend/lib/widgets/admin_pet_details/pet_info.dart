import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class PetInfoWidget extends StatelessWidget {
  final AdminPet pet;

  const PetInfoWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set specific width and height for the Card
      width: 370, // Change to your desired width
      // height: 300, // Change to your desired height if needed
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 10.0, // How blurred the shadow is
            spreadRadius: 0.5, // How much the shadow spreads
            offset: Offset(0, 0), // Direction of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text("Name: ${pet.name}"),
            Text("Description: ${pet.description}"),
            Text("Age: ${pet.age} years old"),
            Text("Breed: ${pet.breed}"),
            Text("Height: ${pet.height} cm"),
            Text("Weight: ${pet.weight} kg"),
            Text("Special Care: ${pet.specialCareInstructions}"),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
