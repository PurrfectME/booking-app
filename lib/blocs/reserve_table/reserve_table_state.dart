// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reserve_table_bloc.dart';

abstract class ReserveTableState extends Equatable {
  const ReserveTableState();

  @override
  List<Object> get props => [];
}

class ReserveTableLoading extends ReserveTableState {}

class ReserveTableError extends ReserveTableState {
  final String error;
  const ReserveTableError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ReserveTableLoaded extends ReserveTableState {
  final int tableId;
  final int placeId;
  const ReserveTableLoaded({
    required this.tableId,
    required this.placeId,
  });

  @override
  List<Object> get props => [tableId, placeId];
}

class ReserveTableSuccess extends ReserveTableState {
  final int tableId;
  final int placeId;
  const ReserveTableSuccess({
    required this.tableId,
    required this.placeId,
  });

  @override
  List<Object> get props => [tableId, placeId];
}
