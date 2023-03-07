// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_info_bloc.dart';

abstract class PlaceInfoEvent extends Equatable {
  const PlaceInfoEvent();

  @override
  List<Object> get props => [];
}

class PlaceInfoLoad extends PlaceInfoEvent {
  final DateTime selectedDateTime;
  const PlaceInfoLoad(
    this.selectedDateTime,
  );

  @override
  List<Object> get props => [selectedDateTime];
}

class UserTableReserve extends PlaceInfoEvent {
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;

  const UserTableReserve(
    this.tableId,
    this.guests,
    this.start,
    this.end,
  );

  @override
  List<Object> get props => [tableId, guests, start, end];
}

class AdminTableReserve extends PlaceInfoEvent {
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;

  const AdminTableReserve({
    required this.tableId,
    required this.guests,
    required this.start,
    required this.end,
    required this.phoneNumber,
    required this.name,
  });

  @override
  List<Object> get props => [tableId, guests, start, end, phoneNumber, name];
}
