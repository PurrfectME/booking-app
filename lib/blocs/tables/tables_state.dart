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
  final List<TableModel> data;

  const TablesLoaded(this.data);

  @override
  List<Object> get props => [data];
}
