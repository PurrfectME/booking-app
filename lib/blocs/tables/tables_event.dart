// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object?> get props => [];
}

class TablesLoad extends TablesEvent {
  const TablesLoad();
}

class CreateTableLoad extends TablesEvent {}

class CreateTable extends TablesEvent {
  final int number;
  final int guests;
  const CreateTable({
    required this.number,
    required this.guests,
  });

  @override
  List<Object?> get props => [number, guests];
}

class TablesPositionsLoad extends TablesEvent {}

class SaveTablesPositions extends TablesEvent {
  final List<TablePosition> positions;
  const SaveTablesPositions({
    required this.positions,
  });

  @override
  List<Object?> get props => [positions];
}
