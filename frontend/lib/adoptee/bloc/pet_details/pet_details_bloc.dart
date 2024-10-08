import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/models/adoption_request/pet.dart';
import 'pet_details_event.dart';
import 'pet_details_state.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_pet_repository.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final PetRepository petRepository;

  PetDetailsBloc({required this.petRepository}) : super(PetDetailsInitial());

  @override
  Stream<PetDetailsState> mapEventToState(PetDetailsEvent event) async* {
    if (event is LoadPetDetailsEvent) {
      yield PetDetailsLoading();
      try {
        final pet = await petRepository.getPetDetails(event.petId);
        yield PetDetailsLoaded(pet: pet);
      } catch (e) {
        yield PetDetailsError(message: e.toString());
      }
    } else if (event is UploadVaccineHistoryEvent) {
      yield PetDetailsLoading();
      try {
        final imageUrl =
            await petRepository.uploadVaccineHistory(event.imageFile);
        yield VaccineHistoryUploaded(imageUrl: imageUrl);
      } catch (e) {
        yield PetDetailsError(message: e.toString());
      }
    } else if (event is UploadMedicalHistoryEvent) {
      yield PetDetailsLoading();
      try {
        final imageUrl =
            await petRepository.uploadMedicalHistory(event.imageFile);
        yield MedicalHistoryUploaded(imageUrl: imageUrl);
      } catch (e) {
        yield PetDetailsError(message: e.toString());
      }
    } else if (event is UploadPetEvent) {
      yield PetDetailsLoading();
      try {
        final createdPet =
            await petRepository.createPet(event.pet); // Pass Pet object to repo
        yield PetUploaded(
            imageUrl: createdPet.petImageUrl); // Show URL of newly created pet
      } catch (e) {
        yield PetDetailsError(message: e.toString());
      }
    } else if (event is DeletePetEvent) {
      yield PetDetailsLoading();
      try {
        await petRepository.deletePet(event.petId);
        yield PetDeleted(); // Emit the new PetDeleted state
      } catch (e) {
        yield PetDetailsError(message: e.toString());
      }
    }
  }
}
