import 'dart:io';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

abstract class PetDetailsEvent {}

class LoadPetDetailsEvent extends PetDetailsEvent {
  final String petId;
  LoadPetDetailsEvent({required this.petId});
}

class UpdatePetDetailsEvent extends PetDetailsEvent {
  final AdminPet pet;
  UpdatePetDetailsEvent({required this.pet});
}

