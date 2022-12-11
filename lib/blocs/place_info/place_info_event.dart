// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_info_bloc.dart';

abstract class PlaceInfoEvent extends Equatable {
  const PlaceInfoEvent();

  @override
  List<Object> get props => [];
}

class PlaceInfoLoad extends PlaceInfoEvent {
  final int placeId;

  const PlaceInfoLoad(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class PlaceTableReserve extends PlaceInfoEvent {
  final int id;
  final int guests;
  // final DateTime selectedDateTime;
  final int placeId;
  final DateTime start;
  final DateTime end;

  const PlaceTableReserve(
    this.id,
    this.guests,
    this.placeId,
    this.start,
    this.end,
  );

  @override
  List<Object> get props => [id, guests, placeId, start, end];
}
