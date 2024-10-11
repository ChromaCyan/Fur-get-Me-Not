import 'package:bloc/bloc.dart';
import 'pet_details_event.dart';
import 'pet_details_state.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';

class AdopteePetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final AdminPetRepository petRepository;

  AdopteePetDetailsBloc({required this.petRepository}) : super(PetDetailsInitial()) {
    on<LoadPetDetailsEvent>((event, emit) async {
      emit(PetDetailsLoading());
      try {
        final pet = await petRepository.getPetDetails(event.petId);
        emit(PetDetailsLoaded(pet: pet));
      } catch (e) {
        emit(PetDetailsError(message: e.toString()));
      }
    });

    on<AddPetEvent>((event, emit) async {
      emit(PetDetailsLoading());
      try {
        await petRepository.addPet(event.pet, event.image); // Pass the image as well
        emit(PetCreated());
      } catch (e) {
        emit(PetDetailsError(message: e.toString()));
      }
    });

    on<UpdatePetDetailsEvent>((event, emit) async {
      emit(PetDetailsLoading());
      try {
        await petRepository.updatePet(event.pet);
        final updatedPet = await petRepository.getPetDetails(event.pet.id ?? '');
        emit(PetDetailsLoaded(pet: updatedPet));
      } catch (e) {
        emit(PetDetailsError(message: e.toString()));
      }
    });
    on<DeletePetEvent>((event, emit) async {
      emit(PetDetailsLoading());
      try {
        await petRepository.removePet(event.petId);
        emit(PetDeleted());
      } catch (e) {
        emit(PetDetailsError(message: e.toString()));
      }
    });
  }
}
