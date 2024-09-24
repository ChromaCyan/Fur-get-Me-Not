import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_list/adoption_form_repository.dart';
import 'package:fur_get_me_not/models/adopters/adoption_list/adoption_form.dart';

// Events
abstract class AdoptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitAdoptionForm extends AdoptionEvent {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zipCode;

  SubmitAdoptionForm({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
  });

  @override
  List<Object> get props => [fullName, email, phone, address, city, zipCode];
}

// States
abstract class AdoptionState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptionInitial extends AdoptionState {}

class AdoptionSubmitting extends AdoptionState {}

class AdoptionSubmitted extends AdoptionState {}

class AdoptionError extends AdoptionState {
  final String message;

  AdoptionError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final AdoptionFormRepository adoptionRepository;

  AdoptionBloc(this.adoptionRepository) : super(AdoptionInitial());

  @override
  Stream<AdoptionState> mapEventToState(AdoptionEvent event) async* {
    if (event is SubmitAdoptionForm) {
      yield AdoptionSubmitting();
      try {
        await adoptionRepository.submitAdoptionForm(AdoptionForm(
          fullName: event.fullName,
          email: event.email,
          phone: event.phone,
          address: event.address,
          city: event.city,
          zipCode: event.zipCode,
        ));
        yield AdoptionSubmitted();
      } catch (e) {
        yield AdoptionError('Failed to submit the form');
      }
    }
  }
}