import 'dart:io';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

abstract class AdoptedPetDetailsEvent {}

class LoadAdoptedPetDetailsEvent extends AdoptedPetDetailsEvent {
  final String petId;
  LoadAdoptedPetDetailsEvent({required this.petId});
}

class UpdateAdoptedPetDetailsEvent extends AdoptedPetDetailsEvent {
  final AdoptedPet pet;
  UpdateAdoptedPetDetailsEvent({required this.pet});
}

class UploadPetImageEvent extends AdoptedPetDetailsEvent {
  final File imageFile;
  UploadPetImageEvent({required this.imageFile});
}

class ToggleAdoptedPetInfoViewEvent extends AdoptedPetDetailsEvent {
  final bool showPetInfo;
  ToggleAdoptedPetInfoViewEvent({required this.showPetInfo});
}
