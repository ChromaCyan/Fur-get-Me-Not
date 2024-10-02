import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';

abstract class PetListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<Pet> pets;

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
