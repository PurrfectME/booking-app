// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_scheme_bloc.dart';

class EditSchemeEvent extends Equatable {
  const EditSchemeEvent();

  @override
  List<Object> get props => [];
}

class EditSchemeLoad extends EditSchemeEvent {}

class AddTable extends EditSchemeEvent {
  final TablePosition position;
  final double x;
  final double y;
  const AddTable({
    required this.position,
    required this.x,
    required this.y,
  });

  @override
  List<Object> get props => [position, x, y];
}

class DragTable extends EditSchemeEvent {
  final TablePosition position;
  final double x;
  final double y;
  const DragTable({
    required this.position,
    required this.x,
    required this.y,
  });

  @override
  List<Object> get props => [position, x, y];
}

class SaveScheme extends EditSchemeEvent {}
