import 'dart:io';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

abstract class PetDetailsEvent {}

class LoadPetDetailsEvent extends PetDetailsEvent {
  final String petId;
  LoadPetDetailsEvent({required this.petId});
}

class AddPetEvent extends PetDetailsEvent {
  final AdminPet pet;
  final File image;

  AddPetEvent({required this.pet, required this.image});
}

class UpdatePetDetailsEvent extends PetDetailsEvent {
  final AdminPet pet;
  UpdatePetDetailsEvent({required this.pet});
}

class DeletePetEvent extends PetDetailsEvent {
  final String petId;
  DeletePetEvent({required this.petId});
}
