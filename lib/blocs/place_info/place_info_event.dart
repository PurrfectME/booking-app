part of 'place_info_bloc.dart';

abstract class PlaceInfoEvent extends Equatable {
  const PlaceInfoEvent();

  @override
  List<Object> get props => [];
}

class PlaceInfoLoad extends PlaceInfoEvent {}

class PlaceTableReserve extends PlaceInfoEvent {
  final int id;

  const PlaceTableReserve(this.id);

  @override
  List<Object> get props => [id];
}
