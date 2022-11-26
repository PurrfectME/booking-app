part of 'place_info_bloc.dart';

abstract class PlaceInfoEvent extends Equatable {
  const PlaceInfoEvent();

  @override
  List<Object> get props => [];
}

class PlaceInfoLoad extends PlaceInfoEvent {}

class PlaceTableReserve extends PlaceInfoEvent {
  final int id;
  final int guestsCount;
  final DateTime selectedDateTime;

  const PlaceTableReserve(this.id, this.guestsCount, this.selectedDateTime);

  @override
  List<Object> get props => [id, guestsCount, selectedDateTime];
}
