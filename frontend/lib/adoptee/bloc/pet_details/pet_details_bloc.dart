import 'package:bloc/bloc.dart';
import 'pet_details_event.dart';
import 'pet_details_state.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';

class AdopteePetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final AdminPetRepository petRepository;

  AdopteePetDetailsBloc({required this.petRepository}) : super(PetDetailsInitial()) {
    // Register event handlers
    on<LoadPetDetailsEvent>((event, emit) async {
      emit(PetDetailsLoading());
      try {
        final pet = await petRepository.getPetDetails(event.petId);
        emit(PetDetailsLoaded(pet: pet));
      } catch (e) {
        emit(PetDetailsError(message: e.toString()));
      }
    });
    // You can register other events here if needed
  }
}
