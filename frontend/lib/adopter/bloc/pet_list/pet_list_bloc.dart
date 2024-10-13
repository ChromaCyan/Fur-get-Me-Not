import 'package:flutter_bloc/flutter_bloc.dart';
import 'pet_list_event.dart';
import 'pet_list_state.dart';
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final AdoptedPetRepository petRepository;

  PetListBloc({required this.petRepository}) : super(PetListLoading()) {
    on<LoadPetListEvent>(_onLoadPetListEvent);
    on<UpdatePetEvent>(_onUpdatePetEvent);
    on<ArchivePetEvent>(_onArchivePetEvent);
  }

  void _onLoadPetListEvent(LoadPetListEvent event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    try {
      final List<AdoptedPet> pets = await petRepository.getAllAdoptedPets();
      emit(PetListLoaded(pets: pets));
    } catch (e) {
      emit(PetListError(message: "Failed to load adopted pets: $e"));
    }
  }

  void _onUpdatePetEvent(UpdatePetEvent event, Emitter<PetListState> emit) async {
    try {
      await petRepository.updateAdoptedPet(event.petId, event.updatedPet);
      add(LoadPetListEvent()); // Reload the pet list after updating
    } catch (e) {
      emit(PetListError(message: "Failed to update adopted pet: $e"));
    }
  }

  void _onArchivePetEvent(ArchivePetEvent event, Emitter<PetListState> emit) async {
    try {
      await petRepository.archiveAdoptedPet(event.petId);
      add(LoadPetListEvent()); // Reload the pet list after archiving
    } catch (e) {
      emit(PetListError(message: "Failed to archive adopted pet: $e"));
    }
  }
}
