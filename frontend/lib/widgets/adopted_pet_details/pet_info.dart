import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart'; // For AdminPet
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart'; // For AdoptedPet

class PetInfoWidget extends StatelessWidget {
  final AdminPet? adminPet; // Making it nullable for compatibility
  final AdoptedPet? adoptedPet; // Making it nullable for compatibility

  const PetInfoWidget({
    Key? key,
    this.adminPet,
    this.adoptedPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if adminPet is not null, if it is, use adoptedPet
    final pet = adminPet ?? adoptedPet;

    // If both are null, return an empty container or handle accordingly
    if (pet == null) {
      return Container(); // Or you can show a message indicating no pet info is available
    }

    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85, // 85% of the screen width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            spreadRadius: 0.3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (adminPet != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoBox("Age", "${adminPet!.age}", "years old"),
                  _buildInfoBox("Height", "${adminPet!.height}", "cm"),
                  _buildInfoBox("Weight", "${adminPet!.weight}", "kg"),
                ],
              ),
              Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Text("${adminPet!.description}"),
              Text(
                "Special Care: ${adminPet!.specialCareInstructions}",
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
              ),
            ] else if (adoptedPet != null) ...[
              Text("Name: ${adoptedPet!.name}"),
              Text("Description: ${adoptedPet!.description}"),
              Text("Age: ${adoptedPet!.age} years old"),
              Text("Breed: ${adoptedPet!.breed}"),
              Text("Height: ${adoptedPet!.height} cm"),
              Text("Weight: ${adoptedPet!.weight} kg"),
              Text("Special Care: ${adoptedPet!.specialCareInstructions}"),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual info boxes
  Widget _buildInfoBox(String title, String value, String unit) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
            ),
            Text(
              "$value $unit",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFE9879),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
