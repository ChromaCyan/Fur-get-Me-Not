import 'package:flutter_bloc/flutter_bloc.dart';
import 'pet_management_event.dart';
import 'pet_management_state.dart';
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';

class PetManagementBloc extends Bloc<PetManagementEvent, PetManagementState> {
  final AdminPetRepository petRepository;

  PetManagementBloc({required this.petRepository}) : super(PetManagementLoading()) {
    on<LoadPetManagementEvent>(_onLoadPetManagementEvent);
    on<AddPetEvent>(_onAddPetEvent);
    on<UpdatePetEvent>(_onUpdatePetEvent);
    on<FetchUserPetsEvent>(_onFetchUserPetsEvent);
    on<RemovePetEvent>(_onRemovePetEvent);
  }

  void _onLoadPetManagementEvent(LoadPetManagementEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      final pets = await petRepository.getAvailablePets();
      emit(PetManagementLoaded(pets: pets));
    } catch (e) {
      emit(PetManagementError(message: "Failed to load pets."));
    }
  }

  void _onAddPetEvent(AddPetEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      await petRepository.addPet(event.pet, event.image);
      emit(PetManagementLoaded(pets: await petRepository.getAvailablePets()));
    } catch (e) {
      print("Error while adding pet: $e"); // Log error
      emit(PetManagementError(message: "Failed to add pet: ${e.toString()}"));
    }
  }

  void _onUpdatePetEvent(UpdatePetEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      await petRepository.updatePet(event.pet, image: event.image);
      emit(PetManagementLoaded(pets: await petRepository.getAvailablePets()));
    } catch (e) {
      emit(PetManagementError(message: "Failed to update pet."));
    }
  }

  void _onFetchUserPetsEvent(FetchUserPetsEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      final pets = await petRepository.getUserPets();
      emit(PetManagementLoaded(pets: pets));
    } catch (e) {
      emit(PetManagementError(message: "Failed to load user pets."));
    }
  }

  void _onRemovePetEvent(RemovePetEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      await petRepository.removePet(event.petId);
      final pets = await petRepository.getAvailablePets();
      emit(PetManagementLoaded(pets: pets));
    } catch (e) {
      emit(PetManagementError(message: "Failed to remove pet: ${e.toString()}"));
    }
  }
}