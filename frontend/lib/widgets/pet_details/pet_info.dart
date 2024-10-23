import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class PetInfoWidget extends StatelessWidget {
  final Pet pet;

  const PetInfoWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85, // 85% of the screen width
      constraints: BoxConstraints(minHeight: 250), // Fixed maximum height
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(25), // Rounded corners
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
          mainAxisSize: MainAxisSize.min, // Allow height to adjust based on content
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBox("Age", "${pet.age} years"),
                _buildInfoBox("Height", "${pet.height} cm"),
                _buildInfoBox("Weight", "${pet.weight} kg"),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text("${pet.description}"),
            const SizedBox(height: 8),
            const Text(
              "Breed",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text("${pet.breed}"),
            const SizedBox(height: 8),
            Text(
              "Special Care: ${pet.specialCareInstructions}",
              style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure it adjusts height based on content
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFE9879)),
            ),
          ],
        ),
      ),
    );
  }
}