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
  final List<ReservationViewModel> data;

  const ReservationsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class RemoveReservationSuccess extends ReservationsState {
  final int tableNumber;

  const RemoveReservationSuccess({
    required this.tableNumber,
  });

  @override
  List<Object> get props => [tableNumber];
}

class EditReservationSuccess extends ReservationsState {}
