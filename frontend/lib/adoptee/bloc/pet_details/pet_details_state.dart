import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';

abstract class PetDetailsState {}

class PetDetailsInitial extends PetDetailsState {}

class PetDetailsLoading extends PetDetailsState {}

class PetDetailsLoaded extends PetDetailsState {
  final AdminPet pet;
  PetDetailsLoaded({required this.pet});
}

class PetCreated extends PetDetailsState {}

class PetDetailsError extends PetDetailsState {
  final String message;
  PetDetailsError({required this.message});
}

class PetDeleted extends PetDetailsState {}


