// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class UpdateTableSuccess extends UpdateTableState {
  final int placeId;
  const UpdateTableSuccess(
    this.placeId,
  );

  @override
  List<Object> get props => [placeId];
}
