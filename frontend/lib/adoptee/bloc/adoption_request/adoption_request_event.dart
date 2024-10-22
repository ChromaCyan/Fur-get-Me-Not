import 'package:equatable/equatable.dart';

abstract class AdoptionRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAdoptionRequests extends AdoptionRequestEvent {}

class UpdateAdoptionRequestStatus extends AdoptionRequestEvent {
  final String requestId;
  final String newStatus;
  final int index;

  UpdateAdoptionRequestStatus({
    required this.requestId,
    required this.newStatus,
    required this.index,
  });

  @override
  List<Object> get props => [requestId, newStatus, index];
}
