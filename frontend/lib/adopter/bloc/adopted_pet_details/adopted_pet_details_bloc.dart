import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'adopted_pet_details_event.dart';
import 'adopted_pet_details_state.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';

class AdoptedPetDetailsBloc extends Bloc<AdoptedPetDetailsEvent, AdoptedPetDetailsState> {
  final AdoptedPetRepository petRepository;

  AdoptedPetDetailsBloc({required this.petRepository}) : super(AdoptedPetDetailsInitial()) {
    on<LoadAdoptedPetDetailsEvent>(_onLoadAdoptedPetDetails);
    on<UpdateAdoptedPetDetailsEvent>(_onUpdateAdoptedPetDetails);
    on<ToggleAdoptedPetInfoViewEvent>(_onToggleAdoptedPetInfoView);
  }

  Future<void> _onLoadAdoptedPetDetails(
      LoadAdoptedPetDetailsEvent event, Emitter<AdoptedPetDetailsState> emit) async {
    emit(AdoptedPetDetailsLoading());
    try {
      final pet = await petRepository.getPetDetails(event.petId);
      emit(AdoptedPetDetailsLoaded(pet: pet, showPetInfo: true));
    } catch (e) {
      emit(AdoptedPetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onUpdateAdoptedPetDetails(
      UpdateAdoptedPetDetailsEvent event, Emitter<AdoptedPetDetailsState> emit) async {
    emit(AdoptedPetDetailsLoading());
    try {
      await petRepository.updateAdoptedPet(event.pet.id, event.pet); // Correcting to use updateAdoptedPet
      emit(AdoptedPetDetailsUpdated(pet: event.pet));
    } catch (e) {
      emit(AdoptedPetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onToggleAdoptedPetInfoView(
      ToggleAdoptedPetInfoViewEvent event, Emitter<AdoptedPetDetailsState> emit) async {
    if (state is AdoptedPetDetailsLoaded) {
      final currentState = state as AdoptedPetDetailsLoaded;
      emit(AdoptedPetDetailsLoaded(pet: currentState.pet, showPetInfo: event.showPetInfo));
    }
  }
}
