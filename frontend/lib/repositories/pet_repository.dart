import 'dart:io';
import 'package:fur_get_me_not/models/pet.dart';

class PetRepository {
  // Dummy data
  final Map<String, Pet> _pets = {
    '1': Pet(
      id: '1',
      name: 'Buddy',
      breed: 'Golden Retriever',
      gender: 'Male',
      age: 5,
      height: 60.0,
      weight: 30.0,
      petImageUrl: 'images/pet-cat2.png',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: '*Needs daily walks, \n *30 mins bath, \n *Daily brush',
    ),
    '2': Pet(
      id: '2',
      name: 'Max',
      breed: 'Labrador',
      gender: 'Male',
      age: 3,
      height: 55.0,
      weight: 28.0,
      petImageUrl: 'images/pet-cat1.png',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: 'None',
    ),
    // Add more pets here as needed
  };

  // Fetch pet details by ID
  Future<Pet> getPetDetails(String petId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _pets[petId]!;
  }

  // Update pet details
  Future<void> updatePetDetails(Pet pet) async {
    await Future.delayed(Duration(seconds: 1));
    _pets[pet.id] = pet;
  }

  // Upload pet image
  Future<String> uploadPet(File imageFile) async {
    await Future.delayed(Duration(seconds: 1));
    return 'images/pet-cat1.png';
  }

  // Upload medical history
  Future<String> uploadMedicalHistory(File imageFile) async {
    await Future.delayed(Duration(seconds: 1));
    return 'images/pet-cat2.png';
  }

  // Upload vaccine history
  Future<String> uploadVaccineHistory(File imageFile) async {
    await Future.delayed(Duration(seconds: 1));
    return 'images/pet-cat2.png';
  }

  // Fetch available pets (e.g., for the adoption list)
  Future<List<Pet>> getAvailablePets(String filter) async {
    await Future.delayed(Duration(seconds: 2));
    List<Pet> availablePets = _pets.values.toList();

    // Apply filter logic (optional, based on breed for this example)
    if (filter.isNotEmpty) {
      availablePets = availablePets.where((pet) => pet.breed.toLowerCase().contains(filter.toLowerCase())).toList();
    }

    return availablePets;
  }
}
