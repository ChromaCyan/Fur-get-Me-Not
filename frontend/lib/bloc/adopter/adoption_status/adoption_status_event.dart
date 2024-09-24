import 'package:equatable/equatable.dart';

abstract class AdoptionStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAdoptionStatus extends AdoptionStatusEvent {}
