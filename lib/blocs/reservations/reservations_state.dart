// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservations_bloc.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object> get props => [];
}

class ReservationsLoading extends ReservationsState {}

class ReservationsError extends ReservationsState {
  final String error;
  const ReservationsError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ReservationsLoaded extends ReservationsState {
  final int placeId;
  final List<ReservationViewModel> data;
  const ReservationsLoaded({
    required this.placeId,
    required this.data,
  });

  @override
  List<Object> get props => [data, placeId];
}
