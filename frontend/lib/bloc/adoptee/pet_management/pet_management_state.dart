import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/models/admin_pet.dart';

abstract class PetManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetManagementLoading extends PetManagementState {}

class PetManagementLoaded extends PetManagementState {
  final List<AdminPet> pets; // Change from List<Pet> to List<AdminPet>

  PetManagementLoaded({required this.pets});

  @override
  List<Object?> get props => [pets];
}


class PetManagementError extends PetManagementState {
  final String message;

  PetManagementError({required this.message});

  @override
  List<Object?> get props => [message];
}
