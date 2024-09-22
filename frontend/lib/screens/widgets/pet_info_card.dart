import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/pet.dart';

class PetInfoSection extends StatelessWidget {
  final Pet pet;

  const PetInfoSection({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name: ${pet.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('Breed: ${pet.breed}', style: TextStyle(fontSize: 16)),
        Text('Gender: ${pet.gender}', style: TextStyle(fontSize: 16)),
        Text('Age: ${pet.age} Years', style: TextStyle(fontSize: 16)),
        Text('Height: ${pet.height} cm', style: TextStyle(fontSize: 16)),
        Text('Weight: ${pet.weight} kg', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text('Special Care Instructions:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(pet.specialCareInstructions, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
