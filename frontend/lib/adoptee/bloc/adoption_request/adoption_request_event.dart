import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';

abstract class AdoptionRequestEvent extends Equatable {
  const AdoptionRequestEvent();

  @override
  List<Object> get props => [];
}

class LoadAdoptionRequests extends AdoptionRequestEvent {}

class UpdateAdoptionRequestStatus extends AdoptionRequestEvent {
  final int index;
  final String newStatus;

  const UpdateAdoptionRequestStatus({
    required this.index,
    required this.newStatus,
  });

  @override
  List<Object> get props => [index, newStatus];
}
