import 'dart:io';
import 'package:fur_get_me_not/adoptee/models/adoption_request/pet.dart';

abstract class PetDetailsEvent {}

class LoadPetDetailsEvent extends PetDetailsEvent {
  final String petId;
  LoadPetDetailsEvent({required this.petId});
}

class UpdatePetDetailsEvent extends PetDetailsEvent {
  final Pet pet;
  UpdatePetDetailsEvent({required this.pet});
}

class UploadPetEvent extends PetDetailsEvent {
  final Pet pet; // Change from File to Pet object for upload or create events
  UploadPetEvent({required this.pet});
}

class UploadMedicalHistoryEvent extends PetDetailsEvent {
  final File imageFile;
  UploadMedicalHistoryEvent({required this.imageFile});
}

class UploadVaccineHistoryEvent extends PetDetailsEvent {
  final File imageFile;
  UploadVaccineHistoryEvent({required this.imageFile});
}

class DeletePetEvent extends PetDetailsEvent {
  final String petId;
  DeletePetEvent({required this.petId});
}
