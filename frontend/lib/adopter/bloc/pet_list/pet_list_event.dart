import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

abstract class PetListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPetListEvent extends PetListEvent {}

class UpdatePetEvent extends PetListEvent {
  final String petId;
  final AdoptedPet updatedPet; // Using the AdoptedPet model

  UpdatePetEvent({required this.petId, required this.updatedPet});

  @override
  List<Object?> get props => [petId, updatedPet];
}

class ArchivePetEvent extends PetListEvent {
  final String petId;

  ArchivePetEvent({required this.petId});

  @override
  List<Object?> get props => [petId];
}
