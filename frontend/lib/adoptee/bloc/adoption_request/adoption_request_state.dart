import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';

abstract class AdoptionRequestState extends Equatable {
  const AdoptionRequestState();

  @override
  List<Object> get props => [];
}

class AdoptionRequestInitial extends AdoptionRequestState {}

class AdoptionRequestLoading extends AdoptionRequestState {}

class AdoptionRequestLoaded extends AdoptionRequestState {
  final List<AdoptionRequest> requests;
  final int unreadCount;

  int get adoptionrequestCount => requests.length;

  const AdoptionRequestLoaded({required this.requests, required this.unreadCount});

  @override
  List<Object> get props => [requests, unreadCount];
}


class AdoptionRequestError extends AdoptionRequestState {
  final String message;

  const AdoptionRequestError({required this.message});

  @override
  List<Object> get props => [message];
}
