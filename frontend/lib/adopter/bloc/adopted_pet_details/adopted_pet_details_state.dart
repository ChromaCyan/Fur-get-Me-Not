import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

abstract class AdoptedPetDetailsState {}

class AdoptedPetDetailsInitial extends AdoptedPetDetailsState {}

class AdoptedPetDetailsLoading extends AdoptedPetDetailsState {}

class AdoptedPetDetailsLoaded extends AdoptedPetDetailsState {
  final AdoptedPet pet;
  final bool showPetInfo;
  AdoptedPetDetailsLoaded({required this.pet, this.showPetInfo = true});
}

class AdoptedPetDetailsError extends AdoptedPetDetailsState {
  final String message;
  AdoptedPetDetailsError({required this.message});
}

class AdoptedPetDetailsUpdated extends AdoptedPetDetailsState {
  final AdoptedPet pet;
  AdoptedPetDetailsUpdated({required this.pet});
}

class PetImageUploaded extends AdoptedPetDetailsState {
  final String imageUrl;
  PetImageUploaded({required this.imageUrl});
}
