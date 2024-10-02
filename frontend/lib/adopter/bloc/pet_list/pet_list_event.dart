import 'package:equatable/equatable.dart';

abstract class PetListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPetListEvent extends PetListEvent {}
