// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservation_info_bloc.dart';

abstract class ReservationInfoEvent extends Equatable {
  const ReservationInfoEvent();

  @override
  List<Object> get props => [];
}

class ReservationInfoLoad extends ReservationInfoEvent {
  final int placeId;
  final int reservationId;
  const ReservationInfoLoad({
    required this.placeId,
    required this.reservationId,
  });

  @override
  List<Object> get props => [placeId, reservationId];
}
