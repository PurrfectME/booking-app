// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservation_info_bloc.dart';

abstract class ReservationInfoState extends Equatable {
  const ReservationInfoState();

  @override
  List<Object> get props => [];
}

class ReservationInfoLoading extends ReservationInfoState {}

class ReservationInfoError extends ReservationInfoState {
  final String error;
  const ReservationInfoError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ReservationInfoLoaded extends ReservationInfoState {
  final ReservationViewModel data;
  const ReservationInfoLoaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class ReservationInfoUpdated extends ReservationInfoState {}
