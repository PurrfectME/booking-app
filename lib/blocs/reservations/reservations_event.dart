// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class ReservationsLoad extends ReservationsEvent {
  final int placeId;
  final int start;
  final ReservationStatus status;
  const ReservationsLoad({
    required this.placeId,
    required this.start,
    required this.status,
  });

  @override
  List<Object> get props => [placeId, start, status];
}
