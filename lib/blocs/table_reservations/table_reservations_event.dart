// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'table_reservations_bloc.dart';

abstract class TableReservationsEvent extends Equatable {
  const TableReservationsEvent();

  @override
  List<Object> get props => [];
}

class TableReservationsLoad extends TableReservationsEvent {
  final int placeId;
  const TableReservationsLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class TableRemoveReservation extends TableReservationsEvent {
  final int reservationId;
  final int placeId;
  final int tableNumber;

  const TableRemoveReservation(
      {required this.reservationId,
      required this.placeId,
      required this.tableNumber});

  @override
  List<Object> get props => [reservationId, placeId, tableNumber];
}

class AdminTableReserve extends TableReservationsEvent {
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
  });

  @override
  List<Object> get props =>
      [placeId, tableId, guests, start, end, phoneNumber, name];
}

class AdminEditReservation extends TableReservationsEvent {
  final int reservationId;
  final int placeId;
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;
  final String comment;

  const AdminEditReservation(
      {required this.reservationId,
      required this.placeId,
      required this.tableId,
      required this.guests,
      required this.start,
      required this.end,
      required this.phoneNumber,
      required this.name,
      required this.comment});

  @override
  List<Object> get props => [
        reservationId,
        placeId,
        tableId,
        guests,
        start,
        end,
        phoneNumber,
        name,
        comment
      ];
}
