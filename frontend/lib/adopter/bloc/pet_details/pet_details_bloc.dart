import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pet_details_event.dart';
import 'pet_details_state.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final PetRepository petRepository;

  PetDetailsBloc({required this.petRepository}) : super(PetDetailsInitial()) {
    on<LoadPetDetailsEvent>(_onLoadPetDetails);
    on<TogglePetInfoViewEvent>(_onTogglePetInfoView);
  }

  Future<void> _onLoadPetDetails(
      LoadPetDetailsEvent event, Emitter<PetDetailsState> emit) async {
    emit(PetDetailsLoading());
    try {
      // Fetch pet details, including image URL
      final pet = await petRepository.getPetDetails(event.petId);
      emit(PetDetailsLoaded(pet: pet, showPetInfo: true));
    } catch (e) {
      emit(PetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onTogglePetInfoView(
      TogglePetInfoViewEvent event, Emitter<PetDetailsState> emit) async {
    if (state is PetDetailsLoaded) {
      final currentState = state as PetDetailsLoaded;
      emit(PetDetailsLoaded(
          pet: currentState.pet, showPetInfo: event.showPetInfo));
    }
  }
}
