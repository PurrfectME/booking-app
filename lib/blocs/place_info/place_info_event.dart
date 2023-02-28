// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_info_bloc.dart';

abstract class PlaceInfoEvent extends Equatable {
  final int placeId;
  const PlaceInfoEvent({required this.placeId});

  @override
  List<Object> get props => [placeId];
}

class PlaceInfoLoad extends PlaceInfoEvent {
  final int placeId;
  final int dateInMilliseconds;

  const PlaceInfoLoad(this.placeId, this.dateInMilliseconds)
      : super(placeId: placeId);

  @override
  List<Object> get props => [placeId, dateInMilliseconds];
}

class UserTableReserve extends PlaceInfoEvent {
  final int tableId;
  final int guests;
  final int placeId;
  final DateTime start;
  final DateTime end;

  const UserTableReserve(
    this.tableId,
    this.guests,
    this.placeId,
    this.start,
    this.end,
  ) : super(placeId: placeId);

  @override
  List<Object> get props => [tableId, guests, placeId, start, end];
}

class AdminTableReserve extends PlaceInfoEvent {
  final int placeId;
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;

  const AdminTableReserve({
    required this.placeId,
    required this.tableId,
    required this.guests,
    required this.start,
    required this.end,
    required this.phoneNumber,
    required this.name,
  }) : super(placeId: placeId);

  @override
  List<Object> get props =>
      [placeId, tableId, guests, start, end, phoneNumber, name];
}
