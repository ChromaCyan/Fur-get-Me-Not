import 'dart:io';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

abstract class PetDetailsState {}

class PetDetailsInitial extends PetDetailsState {}

class PetDetailsLoading extends PetDetailsState {}

class PetDetailsLoaded extends PetDetailsState {
  final Pet pet;
  PetDetailsLoaded({required this.pet});
}

class PetDetailsError extends PetDetailsState {
  final String message;
  PetDetailsError({required this.message});
}

class PetDetailsUpdated extends PetDetailsState {
  final Pet pet;
  PetDetailsUpdated({required this.pet});
}

class PetUploaded extends PetDetailsState{
  final String imageUrl;
  PetUploaded({required this.imageUrl});
}

class MedicalHistoryUploaded extends PetDetailsState{
  final String imageUrl;
  MedicalHistoryUploaded({required this.imageUrl});
}

class VaccineHistoryUploaded extends PetDetailsState {
  final String imageUrl;
  VaccineHistoryUploaded({required this.imageUrl});
}
