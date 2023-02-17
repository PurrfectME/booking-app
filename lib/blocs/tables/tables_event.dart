// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tables_bloc.dart';

abstract class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object?> get props => [];
}

class TablesLoad extends TablesEvent {
  final int placeId;

  const TablesLoad({
    required this.placeId,
  });

  @override
  List<Object?> get props => [placeId];
}
