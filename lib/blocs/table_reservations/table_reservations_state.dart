part of 'table_reservations_bloc.dart';

abstract class TableReservationsState extends Equatable {
  const TableReservationsState();

  @override
  List<Object> get props => [];
}

class TableReservationsLoading extends TableReservationsState {}

class TableReservationsError extends TableReservationsState {
  final String error;
  const TableReservationsError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class TableReservationsLoaded extends TableReservationsState {
  final List<TableReservationViewModel> data;

  const TableReservationsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class TableRemoveReservationSuccess extends TableReservationsState {
  final int tableNumber;

  const TableRemoveReservationSuccess({
    required this.tableNumber,
  });

  @override
  List<Object> get props => [tableNumber];
}

class TableEditReservationSuccess extends TableReservationsState {}
