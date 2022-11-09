part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesLoading extends PlacesState {}

class PlacesError extends PlacesState {
  final String error;

  const PlacesError(this.error);

  @override
  List<Object> get props => [error];
}

class PlacesLoaded extends PlacesState {
  final List<PlaceModel> data;

  const PlacesLoaded(this.data);

  @override
  List<Object> get props => [data];
}
