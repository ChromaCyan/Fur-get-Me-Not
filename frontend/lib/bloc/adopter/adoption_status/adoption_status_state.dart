import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/models/adopters/adoption_status/adoption_status.dart';


abstract class AdoptionStatusState extends Equatable {
  const AdoptionStatusState();

  @override
  List<Object> get props => [];
}

class AdoptionStatusInitial extends AdoptionStatusState {}

class AdoptionStatusLoading extends AdoptionStatusState {}

class AdoptionStatusLoaded extends AdoptionStatusState {
  final List<AdoptionRequest> adoptions;

  AdoptionStatusLoaded(this.adoptions);

  @override
  List<Object> get props => [adoptions];
}

class AdoptionStatusError extends AdoptionStatusState {
  final String message;

  AdoptionStatusError(this.message);

  @override
  List<Object> get props => [message];
}
