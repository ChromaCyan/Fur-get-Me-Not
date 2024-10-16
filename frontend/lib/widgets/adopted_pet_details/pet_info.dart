import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

class PetInfoWidget extends StatelessWidget {
  final AdoptedPet pet;

  const PetInfoWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85, // 85% of the screen width
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 7.0, // Blur effect on the shadow
            spreadRadius: 0.3, // Spread of the shadow
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
            const Text(
              "Pet Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoContainer('Name', pet.name),
            _buildInfoContainer('Description', pet.description),
            _buildInfoContainer('Age', "${pet.age} years old"),
            _buildInfoContainer('Breed', pet.breed),
            _buildInfoContainer('Height', "${pet.height} cm"),
            _buildInfoContainer('Weight', "${pet.weight} kg"),
            _buildInfoContainer('Special Care', pet.specialCareInstructions),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Reusable method to create containers for label-value pairs
  Widget _buildInfoContainer(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background for separation
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFE9879),
            ),
          ),
        ],
      ),
    );
  }
}
