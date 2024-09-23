import 'dart:io';
import 'package:fur_get_me_not/models/admin_pet.dart';

class AdminPetRepository {
  // Dummy data with AdminPet instead of Pet
  final Map<String, AdminPet> _pets = {
    '1': AdminPet(
      id: '1',
      name: 'Fredrick',
      breed: 'Calico',
      gender: 'Male',
      age: 5,
      height: 60.0,
      weight: 30.0,
      petImageUrl: 'images/pet-cat4.png',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: '*Needs daily walks, \n *30 mins bath, \n *Daily brush',
    ),
    '2': AdminPet(
      id: '2',
      name: 'Anthony',
      breed: 'Pomian',
      gender: 'Female',
      age: 2,
      height: 55.0,
      weight: 28.0,
      petImageUrl: 'images/pet-cat5.png',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: 'None',
    ),
    '3': AdminPet(
      id: '3',
      name: 'Dave',
      breed: '',
      gender: 'Unknown',
      age: 10,
      height: 55.0,
      weight: 28.0,
      petImageUrl: 'images/cat_wizard.jpg',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: 'None',
    ),
  };

  // Fetch available pets (returning List<AdminPet>)
  Future<List<AdminPet>> getAvailablePets(String filter) async {
    await Future.delayed(Duration(seconds: 2));
    List<AdminPet> availablePets = _pets.values.toList();

    // Apply filter logic (optional, based on breed)
    if (filter.isNotEmpty) {
      availablePets = availablePets.where((pet) => pet.breed.toLowerCase().contains(filter.toLowerCase())).toList();
    }

    return availablePets;
  }

// Other methods remain the same
}
