// lib/repositories/pet_repository.dart

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
      petImageUrl: '',
      medicalHistoryImageUrl: '',
      vaccineHistoryImageUrl: '',
      specialCareInstructions: '*Needs daily walks, \n *30 mins bath, \n *Daily brush',
    ),
  };

  Future<Pet> getPetDetails(String petId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _pets[petId]!;
  }

  Future<void> updatePetDetails(Pet pet) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    _pets[pet.id] = pet;
  }

  Future<String> uploadPet(File imageFile) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate upload delay
    return 'images/pet-cat1.png';
  }

  Future<String> uploadMedicalHistory(File imageFile) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate upload delay
    return 'images/pet-cat2.png';
  }

  Future<String> uploadVaccineHistory(File imageFile) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate upload delay
    return 'images/pet-cat2.png';
  }
}
