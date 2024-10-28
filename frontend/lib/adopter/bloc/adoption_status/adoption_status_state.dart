import 'package:fur_get_me_not/adopter/models/adoption_status/adoption_status.dart';
import 'package:equatable/equatable.dart';

abstract class AdoptionStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptionStatusInitial extends AdoptionStatusState {}

class AdoptionStatusLoading extends AdoptionStatusState {}

class AdoptionStatusLoaded extends AdoptionStatusState {
  final List<AdoptionStatus> adoptionStatusList;

  AdoptionStatusLoaded(this.adoptionStatusList);

  int get statusCount => adoptionStatusList.length;

  @override
  List<Object> get props => [adoptionStatusList];
}

class AdoptionStatusError extends AdoptionStatusState {
  final String message;

  AdoptionStatusError(this.message);

  @override
  List<Object> get props => [message];
}
