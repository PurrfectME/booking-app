part of 'update_tables_bloc.dart';

abstract class UpdateTablesEvent extends Equatable {
  const UpdateTablesEvent();

  @override
  List<Object> get props => [];
}

class UpdateTablesLoad extends UpdateTablesEvent {
  final List<TableModel> data;

  const UpdateTablesLoad(this.data);

  @override
  List<Object> get props => [data];
}

class UpdateTables extends UpdateTablesEvent {
  final List<TableModel> data;

  const UpdateTables(this.data);

  @override
  List<Object> get props => [data];
}
