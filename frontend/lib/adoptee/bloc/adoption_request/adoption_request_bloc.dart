import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';

import 'adoption_request_event.dart';
import 'adoption_request_state.dart';

class AdoptionRequestBloc extends Bloc<AdoptionRequestEvent, AdoptionRequestState> {
  final AdoptionRequestRepository repository;

  AdoptionRequestBloc({required this.repository}) : super(AdoptionRequestInitial()) {
    on<LoadAdoptionRequests>((event, emit) async {
      emit(AdoptionRequestLoading());
      try {
        final requests = await repository.fetchAdoptionRequests(); // Changed to fetchAdoptionRequests
        emit(AdoptionRequestLoaded(requests: requests));
      } catch (e) {
        emit(AdoptionRequestError(message: 'Failed to load adoption requests'));
      }
    });

    on<UpdateAdoptionRequestStatus>((event, emit) async {
      if (state is AdoptionRequestLoaded) {
        final currentState = state as AdoptionRequestLoaded;
        final updatedRequests = List<AdoptionRequest>.from(currentState.requests);

        // Call the repository to update the status using the requestId
        await repository.updateAdoptionRequestStatus(event.requestId, updatedRequests[event.index], event.newStatus);

        // Update the request status locally
        updatedRequests[event.index].requestStatus = event.newStatus;

        emit(AdoptionRequestLoaded(requests: updatedRequests));
      }
    });

  }
}
