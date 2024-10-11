import 'package:flutter/material.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

class PetCard extends StatelessWidget {
  final AdminPet pet;
  final Size size;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PetCard({
    Key? key,
    required this.pet,
    required this.size,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: size.height * 0.3,
            width: size.width * 0.55,
            color: const Color(0xFF21899C),
            child: Stack(
              children: [
                Positioned(
                  bottom: -10,
                  right: -10,
                  height: 100,
                  width: 100,
                  child: Transform.rotate(
                    angle: 12,
                    child: Image.asset(
                      "images/paw1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 10,
                  child: Hero(
                    tag: pet.id ?? '',
                    child: Image.network(
                      pet.petImageUrl,
                      height: size.height * 0.30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: onEdit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Updated
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            child: Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: onDelete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Updated
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
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
