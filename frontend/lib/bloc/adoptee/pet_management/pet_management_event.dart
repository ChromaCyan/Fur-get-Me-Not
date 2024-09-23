import 'package:equatable/equatable.dart';

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
