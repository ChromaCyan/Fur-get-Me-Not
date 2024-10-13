import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

class AdoptedPetCard extends StatelessWidget {
  final AdoptedPet adoptedPet;
  final Size size;
  final VoidCallback onTap;

  const AdoptedPetCard({
    Key? key,
    required this.adoptedPet,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = size.width;
    double cardWidth = (screenWidth / 2) - 16;
    double cardHeight = cardWidth * 1.25;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: Color(0xFF21899C),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black.withOpacity(0.3),
                //   blurRadius: 4,
                //   offset: Offset(0, 4),
                // ),
              ],
            ),
            // Image area
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    // Displaying of image
                    child: Image.network(
                      adoptedPet.petImageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adoptedPet.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          adoptedPet.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${adoptedPet.breed}, ${adoptedPet.gender}, ${adoptedPet.age} years', // Added breed, gender, and age
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
