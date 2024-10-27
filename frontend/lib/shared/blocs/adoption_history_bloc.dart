import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/shared/models/adoption_history.dart';
import 'package:fur_get_me_not/shared/repository/adoption_history_repository.dart';

// Events
abstract class AdoptionHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAdoptionHistory extends AdoptionHistoryEvent {}

// States
abstract class AdoptionHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptionHistoryInitial extends AdoptionHistoryState {}

class AdoptionHistoryLoading extends AdoptionHistoryState {}

class AdoptionHistoryLoaded extends AdoptionHistoryState {
  final List<AdoptionHistory> adoptionHistory;

  AdoptionHistoryLoaded(this.adoptionHistory);

  @override
  List<Object> get props => [adoptionHistory];
}

class AdoptionHistoryError extends AdoptionHistoryState {
  final String message;

  AdoptionHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class AdoptionHistoryBloc extends Bloc<AdoptionHistoryEvent, AdoptionHistoryState> {
  final AdoptionHistoryRepository adoptionHistoryRepository;

  AdoptionHistoryBloc({required this.adoptionHistoryRepository})
      : super(AdoptionHistoryInitial()) {
    on<FetchAdoptionHistory>((event, emit) async {
      emit(AdoptionHistoryLoading());
      try {
        final adoptionHistory = await adoptionHistoryRepository.fetchAdoptionHistory();
        emit(AdoptionHistoryLoaded(adoptionHistory));
      } catch (e) {
        emit(AdoptionHistoryError(e.toString()));
      }
    });
  }
}
