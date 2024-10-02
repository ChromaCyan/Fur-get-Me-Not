import 'package:equatable/equatable.dart';

abstract class AdoptionBrowseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAdoptionBrowseEvent extends AdoptionBrowseEvent {
  final String filter;

  LoadAdoptionBrowseEvent({this.filter = ''});

  @override
  List<Object?> get props => [filter];
}