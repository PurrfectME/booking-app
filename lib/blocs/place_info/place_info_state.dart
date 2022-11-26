part of 'place_info_bloc.dart';

abstract class PlaceInfoState extends Equatable {
  const PlaceInfoState();

  @override
  List<Object> get props => [];
}

class PlaceInfoLoading extends PlaceInfoState {}

class PlaceInfoError extends PlaceInfoState {
  final String error;

  const PlaceInfoError(this.error);

  @override
  List<Object> get props => [error];
}

class PlaceInfoLoaded extends PlaceInfoState {
  final List<TableModel> data;

  const PlaceInfoLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class PlaceTableReserveSuccess extends PlaceInfoState {
  final int id;

  const PlaceTableReserveSuccess({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
