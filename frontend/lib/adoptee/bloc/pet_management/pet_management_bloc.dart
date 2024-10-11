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
    on<DeletePetEvent>(_onDeletePetEvent);
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
      await petRepository.addPet(event.pet);
      emit(PetManagementLoaded(pets: await petRepository.getAvailablePets())); // Reload pets after adding
    } catch (e) {
      emit(PetManagementError(message: "Failed to add pet."));
    }
  }

  void _onUpdatePetEvent(UpdatePetEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      await petRepository.updatePet(event.pet);
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

  void _onDeletePetEvent(DeletePetEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      await petRepository.deletePet(event.petId);
      emit(PetManagementLoaded(pets: await petRepository.getAvailablePets()));
    } catch (e) {
      emit(PetManagementError(message: "Failed to delete pet."));
    }
  }
}
