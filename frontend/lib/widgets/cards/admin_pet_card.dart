import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class PetCard extends StatelessWidget {
  final AdminPet pet;
  final Size size;
  final VoidCallback onTap;

  const PetCard({
    Key? key,
    required this.pet,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = size.width;
    double cardWidth = (screenWidth / 2) - 16;
    double cardHeight = cardWidth * 1.50;

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF21899C),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black.withOpacity(0.3),
                //   blurRadius: 4,
                //   offset: Offset(0, 4),
                // ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    // Displaying of image
                    child: Hero(
                      tag: pet.id ?? '',
                      child: Image.network(
                        pet.petImageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
                          pet.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Description here",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        // Removed Edit and Delete buttons
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
