import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';

abstract class PetListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<AdoptedPet> pets; // Updated type

  PetListLoaded({required this.pets});

  @override
  List<Object?> get props => [pets];
}

class PetListError extends PetListState {
  final String message;

  PetListError({required this.message});

  @override
  List<Object?> get props => [message];
}
