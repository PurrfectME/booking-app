// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'table_info_bloc.dart';

abstract class TableInfoEvent extends Equatable {
  const TableInfoEvent();

  @override
  List<Object> get props => [];
}

class TableInfoLoad extends TableInfoEvent {
  final int placeId;
  final TableModel table;

  const TableInfoLoad({
    required this.placeId,
    required this.table,
  });

  @override
  List<Object> get props => [placeId, table];
}
