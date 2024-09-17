import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/models/pet.dart';

abstract class AdoptionBrowseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdoptionBrowseLoading extends AdoptionBrowseState {}

class AdoptionBrowseLoaded extends AdoptionBrowseState {
  final List<Pet> pets;

  AdoptionBrowseLoaded({required this.pets});

  @override
  List<Object?> get props => [pets];
}

class AdoptionBrowseError extends AdoptionBrowseState {
  final String message;

  AdoptionBrowseError({required this.message});

  @override
  List<Object?> get props => [message];
}

