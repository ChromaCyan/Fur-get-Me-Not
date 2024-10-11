import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'dart:io';


abstract class PetManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPetManagementEvent extends PetManagementEvent {
  final String filter;

  LoadPetManagementEvent({this.filter = ''});

  @override
  List<Object?> get props => [filter];
}

class AddPetEvent extends PetManagementEvent {
  final AdminPet pet;
  final File image;

  AddPetEvent({required this.pet, required this.image});

  @override
  List<Object?> get props => [pet];
}

class UpdatePetEvent extends PetManagementEvent {
  final AdminPet pet;
  final File? image;

  UpdatePetEvent({required this.pet, this.image});

  @override
  List<Object?> get props => [pet, image]; // Include image in props
}
class FetchUserPetsEvent extends PetManagementEvent {}

class RemovePetEvent extends PetManagementEvent {
  final String petId;

  RemovePetEvent({required this.petId});

  @override
  List<Object?> get props => [petId];
}