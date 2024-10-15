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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
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
                        const Text(
                          "Age",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.age} years",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9879)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                        const Text(
                          "Height",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.height} cm",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9879)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                        const Text(
                          "Weight",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.weight} kg",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9879)),
                        ),
                      ],
                    ),
                  ),
                ),
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
}
