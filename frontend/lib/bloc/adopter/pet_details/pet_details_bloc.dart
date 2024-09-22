import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/models/pet.dart';
import 'pet_details_event.dart';
import 'pet_details_state.dart';
import 'package:fur_get_me_not/repositories/pet_repository.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final PetRepository petRepository;

  PetDetailsBloc({required this.petRepository}) : super(PetDetailsInitial()) {
    on<LoadPetDetailsEvent>(_onLoadPetDetails);
    on<UploadVaccineHistoryEvent>(_onUploadVaccineHistory);
    on<UploadMedicalHistoryEvent>(_onUploadMedicalHistory);
    on<UploadPetEvent>(_onUploadPet);
    on<TogglePetInfoViewEvent>(_onTogglePetInfoView);
  }

  Future<void> _onLoadPetDetails(
      LoadPetDetailsEvent event, Emitter<PetDetailsState> emit) async {
    emit(PetDetailsLoading());
    try {
      final pet = await petRepository.getPetDetails(event.petId);
      emit(PetDetailsLoaded(pet: pet, showPetInfo: true));
    } catch (e) {
      emit(PetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onUploadVaccineHistory(
      UploadVaccineHistoryEvent event, Emitter<PetDetailsState> emit) async {
    emit(PetDetailsLoading());
    try {
      final imageUrl = await petRepository.uploadVaccineHistory(event.imageFile);
      emit(VaccineHistoryUploaded(imageUrl: imageUrl));
    } catch (e) {
      emit(PetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onUploadMedicalHistory(
      UploadMedicalHistoryEvent event, Emitter<PetDetailsState> emit) async {
    emit(PetDetailsLoading());
    try {
      final imageUrl = await petRepository.uploadMedicalHistory(event.imageFile);
      emit(MedicalHistoryUploaded(imageUrl: imageUrl));
    } catch (e) {
      emit(PetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onUploadPet(
      UploadPetEvent event, Emitter<PetDetailsState> emit) async {
    emit(PetDetailsLoading());
    try {
      final imageUrl = await petRepository.uploadPet(event.imageFile);
      emit(PetUploaded(imageUrl: imageUrl));
    } catch (e) {
      emit(PetDetailsError(message: e.toString()));
    }
  }

  Future<void> _onTogglePetInfoView(
      TogglePetInfoViewEvent event, Emitter<PetDetailsState> emit) async {
    if (state is PetDetailsLoaded) {
      final currentState = state as PetDetailsLoaded;
      emit(PetDetailsLoaded(pet: currentState.pet, showPetInfo: event.showPetInfo));
    }
  }
}
