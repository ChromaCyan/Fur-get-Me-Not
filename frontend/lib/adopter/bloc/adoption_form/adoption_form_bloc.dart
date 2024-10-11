import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/adoption_form.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/adoption_form_repository.dart';

// Events
abstract class AdoptionEvent {}

class SubmitAdoptionForm extends AdoptionEvent {
  final AdoptionFormModel adoptionForm;

  SubmitAdoptionForm(this.adoptionForm);
}

// States
abstract class AdoptionState {}

class AdoptionInitial extends AdoptionState {}

class AdoptionSubmitting extends AdoptionState {}

class AdoptionSubmitted extends AdoptionState {}

class AdoptionError extends AdoptionState {
  final String message;

  AdoptionError(this.message);
}

// Bloc
class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final AdoptionFormRepository repository;

  AdoptionBloc(this.repository) : super(AdoptionInitial()) {
    on<SubmitAdoptionForm>((event, emit) async {
      emit(AdoptionSubmitting());
      try {
        final success = await repository.submitAdoptionForm(event.adoptionForm);
        if (success) {
          emit(AdoptionSubmitted());
        } else {
          emit(AdoptionError('Submission failed. Please try again.'));
        }
      } catch (e) {
        emit(AdoptionError('Error: $e'));
      }
    });
  }
}
