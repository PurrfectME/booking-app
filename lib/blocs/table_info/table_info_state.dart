// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'table_info_bloc.dart';

abstract class TableInfoState extends Equatable {
  const TableInfoState();

  @override
  List<Object> get props => [];
}

class TableInfoLoading extends TableInfoState {}

class TableInfoLoaded extends TableInfoState {
  final TableInfoViewModel data;
  const TableInfoLoaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class TableInfoErorr extends TableInfoState {
  final String error;
  const TableInfoErorr({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
