import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class PetInfoWidget extends StatelessWidget {
  final AdminPet pet;

  const PetInfoWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Set width and height relative to the screen size
      width: screenWidth * 0.85, // 90% of the screen width
      // height: screenHeight * 0.4, // Optional: 40% of the screen height

      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 7.0, // How blurred the shadow is
            spreadRadius: 0.3, // How much the shadow spreads
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
            // Text(
            //   "Name: ${pet.name}",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Ensures equal spacing between columns
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(
                        4.0), // Optional: Spacing between containers
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0), // Inner padding
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[200], // Light background color for containers
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Wrap content size
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.age}",
                          style: TextStyle(
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
                        Text(
                          "Height",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.height} cm",
                          style: TextStyle(
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
                        Text(
                          "Weight",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${pet.weight} kg",
                          style: TextStyle(
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
            Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            Text(
              "${pet.description}",
            ),

            Text(
              "Special Care: ${pet.specialCareInstructions}",
              style: TextStyle(
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
