// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tables_bloc.dart';

abstract class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

class TablesLoading extends TablesState {}

class TablesError extends TablesState {
  final String error;

  const TablesError(this.error);

  @override
  List<Object> get props => [error];
}

class TablesLoaded extends TablesState {
  final List<TableViewModel> data;

  const TablesLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class TableCreated extends TablesState {
  final int placeId;
  const TableCreated({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class CreateTableLoaded extends TablesState {
  final int placeId;
  const CreateTableLoaded({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class TablesPositionsLoading extends TablesState {}

class TablesPositionsLoaded extends TablesState {
  final List<TablePositionWrapper> positions;
  const TablesPositionsLoaded({
    required this.positions,
  });

  @override
  List<Object> get props => [positions];
}

class TablesPositionsUpdated extends TablesState {}
