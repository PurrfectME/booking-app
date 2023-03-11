// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class ReservationsLoad extends ReservationsEvent {
  final int placeId;
  const ReservationsLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class RemoveReservation extends ReservationsEvent {
  final int reservationId;
  final int placeId;
  final int tableNumber;

  const RemoveReservation(
      {required this.reservationId,
      required this.placeId,
      required this.tableNumber});

  @override
  List<Object> get props => [reservationId, placeId, tableNumber];
}

class AdminTableReserve extends ReservationsEvent {
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

class AdminEditReservation extends ReservationsEvent {
  final int reservationId;
  final int placeId;
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;

  const AdminEditReservation({
    required this.reservationId,
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
      [reservationId, placeId, tableId, guests, start, end, phoneNumber, name];
}
