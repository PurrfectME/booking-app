// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class ReservationsLoad extends ReservationsEvent {}

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
