part of 'update_tables_bloc.dart';

abstract class UpdateTablesState extends Equatable {
  const UpdateTablesState();

  @override
  List<Object> get props => [];
}

class UpdateTablesLoading extends UpdateTablesState {}

class UpdateTablesError extends UpdateTablesState {
  final String error;

  const UpdateTablesError(this.error);

  @override
  List<Object> get props => [error];
}

class UpdateTablesLoaded extends UpdateTablesState {
  final List<TableModel> data;

  const UpdateTablesLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UpdateTablesSuccess extends UpdateTablesState {}
