import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/models/adoptee/adoption_request/adoption_request.dart';

abstract class AdoptionRequestState extends Equatable {
  const AdoptionRequestState();

  @override
  List<Object> get props => [];
}

class AdoptionRequestInitial extends AdoptionRequestState {}

class AdoptionRequestLoading extends AdoptionRequestState {}

class AdoptionRequestLoaded extends AdoptionRequestState {
  final List<AdoptionRequest> requests;

  const AdoptionRequestLoaded({required this.requests});

  @override
  List<Object> get props => [requests];
}

class AdoptionRequestError extends AdoptionRequestState {
  final String message;

  const AdoptionRequestError({required this.message});

  @override
  List<Object> get props => [message];
}
