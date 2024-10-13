import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_form.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';

// Events
abstract class AdoptionEvent {}

class FetchAdoptionForm extends AdoptionEvent {
  final String requestId;

  FetchAdoptionForm(this.requestId);
}

// States
abstract class AdoptionState {}

class AdoptionInitial extends AdoptionState {}

class AdoptionLoading extends AdoptionState {}

class AdoptionLoaded extends AdoptionState {
  final AdminAdoptionForm adoptionForm;

  AdoptionLoaded(this.adoptionForm);
}

class AdoptionError extends AdoptionState {
  final String message;

  AdoptionError(this.message);
}

// Bloc
class AdminAdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final AdoptionRequestRepository repository;

  AdminAdoptionBloc(this.repository) : super(AdoptionInitial()) {
    on<FetchAdoptionForm>((event, emit) async {
      emit(AdoptionLoading());
      try {
        final form = await repository.fetchAdoptionFormByRequestId(event.requestId);
        emit(AdoptionLoaded(form));
      } catch (e) {
        emit(AdoptionError('Error fetching adoption form: $e'));
      }
    });
  }
}
