import 'package:flutter/material.dart';
import 'package:fur_get_me_not/models/pet.dart';

class PetDetailWidget extends StatelessWidget {
  final Pet pet;
  final VoidCallback onAdopt;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PetDetailWidget({
    Key? key,
    required this.pet,
    required this.onAdopt,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          _buildImageAndBackground(size, pet.petImageUrl),
          _buildBackButton(size, context),
          Positioned(
            bottom: 0,
            child: _buildPetDetailsContainer(size),
          ),
        ],
      ),
    );
  }
  Widget _buildImageAndBackground(Size size, String imageUrl) {
    return Container(
      height: size.height * 0.4, // Adjust the height as needed
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPetDetailsContainer(Size size) {
    return Container(
      height: size.height * 0.52,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildNameAndActionButtons(),
              const SizedBox(height: 30),
              _buildInfoRow(),
              const SizedBox(height: 20),
              _buildOwnerInfo(),
              const SizedBox(height: 20),
              _buildAdoptButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildBackButton(Size size, BuildContext context) {
    return Positioned(
      height: size.height * 0.14,
      right: 20,
      left: 20,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
      ),
    );
  }

  Widget _buildNameAndActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Text(
            pet.name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: onEdit, // Placeholder for edit action
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // Placeholder for delete action
        ),
      ],
    );
  }

  Widget _buildOwnerInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: pet.gender == 'Male' ? Colors.blue : Colors.pink,
          backgroundImage: const AssetImage('images/image2.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sophia Black',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to chat screen
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chat_outlined, color: Colors.lightBlue, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMoreInfo(Colors.blue, Colors.blue.withOpacity(0.5), pet.gender, "Gender"),
        _buildMoreInfo(Colors.green, Colors.green.withOpacity(0.5), pet.breed, "Breed"),
        _buildMoreInfo(Colors.orange, Colors.orange.withOpacity(0.5), "${pet.age} Years", "Age"),
      ],
    );
  }

  ClipRRect _buildMoreInfo(Color pawColor, Color backgroundColor, String title, String value) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: 0,
            child: Transform.rotate(
              angle: 12,
              child: Image.asset(
                'images/pet-cat2.png',
                color: Colors.black,
                height: 55,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdoptButton() {
    return GestureDetector(
      onTap: onAdopt,
      child: Container(
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.green),
        child: const Center(
          child: Text('Adopt Me', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
