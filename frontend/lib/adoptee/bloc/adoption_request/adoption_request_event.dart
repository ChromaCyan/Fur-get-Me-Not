import 'package:equatable/equatable.dart';

abstract class AdoptionRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAdoptionRequests extends AdoptionRequestEvent {}

class UpdateAdoptionRequestStatus extends AdoptionRequestEvent {
  final String requestId; // The requestId of the adoption request
  final String newStatus;  // The new status for the request
  final int index;         // The index of the request in the list

  UpdateAdoptionRequestStatus({
    required this.requestId,
    required this.newStatus,
    required this.index,  // Include the index in the constructor
  });

  @override
  List<Object> get props => [requestId, newStatus, index];
}
