part of 'update_table_bloc.dart';

abstract class UpdateTableState extends Equatable {
  const UpdateTableState();

  @override
  List<Object> get props => [];
}

class UpdateTableLoading extends UpdateTableState {}

class UpdateTableError extends UpdateTableState {
  final String error;

  const UpdateTableError(this.error);

  @override
  List<Object> get props => [error];
}

class UpdateTableLoaded extends UpdateTableState {
  final TableViewModel data;

  const UpdateTableLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UpdateTableSuccess extends UpdateTableState {}
