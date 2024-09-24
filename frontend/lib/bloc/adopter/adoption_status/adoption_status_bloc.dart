import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/models/adopters/adoption_status/adoption_status.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_status/adoption_status_repository.dart';
import 'adoption_status_event.dart';
import 'adoption_status_state.dart';

class AdoptionStatusBloc extends Bloc<AdoptionStatusEvent, AdoptionStatusState> {
  final AdoptionStatusRepository _repository;

  AdoptionStatusBloc(this._repository) : super(AdoptionStatusInitial()) {
    on<LoadAdoptions>((event, emit) async {
      try {
        final adoptions = await _repository.getAdoptions();
        emit(AdoptionStatusLoaded(adoptions));
      } catch (_) {
        emit(AdoptionStatusError('Failed to load adoptions'));
      }
    });
  }
}
