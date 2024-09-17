import 'package:equatable/equatable.dart';

abstract class AdoptionStatusEvent extends Equatable {
  const AdoptionStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadAdoptions extends AdoptionStatusEvent {}