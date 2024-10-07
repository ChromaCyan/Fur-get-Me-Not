import 'dart:io';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

class AdoptedPetRepository {
  // Dummy data
  final Map<String, Pet> _pets = {
    '1': Pet(
      id: '1',
      name: 'Arthur',
      breed: 'Calico',
      gender: 'Male',
      age: 5,
      height: 60.0,
      weight: 30.0,
      petImageUrl: 'images/pet-cat2.png',
      medicalHistoryImageUrl: 'images/pet_medical_image.png',
      vaccineHistoryImageUrl: 'images/pet_vaccine_image.jpg',
      specialCareInstructions: '*Needs daily walks, \n *30 mins bath, \n *Daily brush',
    ),
  };

  // Fetch pet details by ID
  Future<Pet> getPetDetails(String petId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _pets[petId]!;
  }

  Future<List<Pet>> getAllPets() async {
    await Future.delayed(Duration(seconds: 2));
    return _pets.values.toList();
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

    if (filter.isNotEmpty) {
      availablePets = availablePets.where((pet) => pet.breed.toLowerCase().contains(filter.toLowerCase())).toList();
    }

    return availablePets;
  }
}