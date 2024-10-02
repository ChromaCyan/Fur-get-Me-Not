import 'package:flutter_bloc/flutter_bloc.dart';
import 'pet_list_event.dart';
import 'pet_list_state.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final AdoptedPetRepository petRepository;

  PetListBloc({required this.petRepository}) : super(PetListLoading()) {
    on<LoadPetListEvent>(_onLoadPetListEvent);
  }

  void _onLoadPetListEvent(LoadPetListEvent event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    try {
      final pets = await petRepository.getAllPets();
      emit(PetListLoaded(pets: pets));
    } catch (e) {
      emit(PetListError(message: "Failed to load adopted pets."));
    }
  }
}
