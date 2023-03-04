part of 'update_table_bloc.dart';

abstract class UpdateTableEvent extends Equatable {
  const UpdateTableEvent();

  @override
  List<Object> get props => [];
}

class UpdateTableLoad extends UpdateTableEvent {
  const UpdateTableLoad();
}

class UpdateTable extends UpdateTableEvent {
  final TableViewModel data;

  const UpdateTable(this.data);

  @override
  List<Object> get props => [data];
}
