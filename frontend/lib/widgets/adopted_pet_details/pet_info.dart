import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

class PetInfoWidget extends StatelessWidget {
  final AdoptedPet pet;

  const PetInfoWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: ${pet.name}"),
        Text("Description: ${pet.description}"),
        Text("Age: ${pet.age} years old"),
        Text("Breed: ${pet.breed}"),
        Text("Height: ${pet.height} cm"),
        Text("Weight: ${pet.weight} kg"),
        Text("Special Care: ${pet.specialCareInstructions}"),
      ],
    );
  }
}
