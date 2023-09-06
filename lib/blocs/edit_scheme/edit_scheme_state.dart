// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_scheme_bloc.dart';

class EditSchemeState extends Equatable {
  const EditSchemeState();

  @override
  List<Object> get props => [];
}

class EditSchemeLoading extends EditSchemeState {}

class EditSchemeLoaded extends EditSchemeState {
  final List<TablePositionWrapper> droppedTables;
  final List<TableModel> availableTables;
  const EditSchemeLoaded({
    required this.droppedTables,
    required this.availableTables,
  });

  @override
  List<Object> get props => [droppedTables, availableTables];
}

class SchemeSaved extends EditSchemeState {}
