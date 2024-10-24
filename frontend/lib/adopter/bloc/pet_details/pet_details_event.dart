import 'dart:io';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

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
  final File imageFile;
  UploadPetEvent({required this.imageFile});
}

// Commented out unused events
// class UploadMedicalHistoryEvent extends PetDetailsEvent {
//   final File imageFile;
//   UploadMedicalHistoryEvent({required this.imageFile});
// }

// class UploadVaccineHistoryEvent extends PetDetailsEvent {
//   final File imageFile;
//   UploadVaccineHistoryEvent({required this.imageFile});
// }

class TogglePetInfoViewEvent extends PetDetailsEvent {
  final bool showPetInfo;
  TogglePetInfoViewEvent({required this.showPetInfo});
}
