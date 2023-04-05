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
  final ReservationStatus status;
  const ReservationInfoLoad({
    required this.placeId,
    required this.reservationId,
    required this.status,
  });

  @override
  List<Object> get props => [placeId, reservationId, status];
}

class ReservationOpen extends ReservationInfoEvent {
  final int placeId;
  final int reservationId;

  const ReservationOpen({
    required this.placeId,
    required this.reservationId,
  });

  @override
  List<Object> get props => [placeId, reservationId];
}

class ReservationCancel extends ReservationInfoEvent {
  final int placeId;
  final int reservationId;

  const ReservationCancel({
    required this.placeId,
    required this.reservationId,
  });

  @override
  List<Object> get props => [placeId, reservationId];
}

class ReservationWait extends ReservationInfoEvent {
  final int placeId;
  final int reservationId;

  const ReservationWait({
    required this.placeId,
    required this.reservationId,
  });

  @override
  List<Object> get props => [placeId, reservationId];
}

class ReservationInfoEdit extends ReservationInfoEvent {
  final int reservationId;
  final int placeId;
  final int tableId;
  final int guests;
  final DateTime start;
  final DateTime end;
  final String phoneNumber;
  final String name;
  final bool excludeReshuffle;
  final String? comment;

  const ReservationInfoEdit({
    required this.reservationId,
    required this.placeId,
    required this.tableId,
    required this.guests,
    required this.start,
    required this.end,
    required this.phoneNumber,
    required this.name,
    required this.excludeReshuffle,
    required this.comment,
  });

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
        excludeReshuffle,
      ];
}
