import 'package:flutter_bloc/flutter_bloc.dart';
import 'pet_management_event.dart';
import 'pet_management_state.dart';
import 'package:fur_get_me_not/models/adoptee/pet_management/admin_pet.dart';
import 'package:fur_get_me_not/repositories/adoptee/pet_management/admin_pet_repository.dart';

class PetManagementBloc extends Bloc<PetManagementEvent, PetManagementState> {
  final AdminPetRepository petRepository;

  PetManagementBloc({required this.petRepository}) : super(PetManagementLoading()) {
    on<LoadPetManagementEvent>(_onLoadPetManagementEvent);
  }

  void _onLoadPetManagementEvent(LoadPetManagementEvent event, Emitter<PetManagementState> emit) async {
    emit(PetManagementLoading());
    try {
      final pets = await petRepository.getAvailablePets(event.filter);
      emit(PetManagementLoaded(pets: pets));
    } catch (e) {
      emit(PetManagementError(message: "Failed to load pets."));
    }
  }
}
