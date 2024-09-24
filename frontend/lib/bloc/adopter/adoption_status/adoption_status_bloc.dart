import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_status/adoption_status_repository.dart';
import 'adoption_status_event.dart';
import 'adoption_status_state.dart';

class AdoptionStatusBloc extends Bloc<AdoptionStatusEvent, AdoptionStatusState> {
  final AdoptionStatusRepository adoptionStatusRepository;

  AdoptionStatusBloc({required this.adoptionStatusRepository}) : super(AdoptionStatusInitial()) {
    on<LoadAdoptionStatus>((event, emit) async {
      emit(AdoptionStatusLoading());
      try {
        final adoptionStatusList = await adoptionStatusRepository.fetchAdoptions();
        emit(AdoptionStatusLoaded(adoptionStatusList));
      } catch (error) {
        emit(AdoptionStatusError(error.toString()));
      }
    });
  }
}
