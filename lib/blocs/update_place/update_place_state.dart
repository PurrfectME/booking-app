part of 'update_place_bloc.dart';

abstract class UpdatePlaceState extends Equatable {
  const UpdatePlaceState();

  @override
  List<Object> get props => [];
}

class UpdatePlaceLoading extends UpdatePlaceState {}

class UpdatePlaceError extends UpdatePlaceState {
  final String error;

  const UpdatePlaceError(this.error);

  @override
  List<Object> get props => [error];
}

class UpdatePlaceLoaded extends UpdatePlaceState {
  final PlaceModel? data;

  const UpdatePlaceLoaded(this.data);
}

class UpdatePlaceSuccess extends UpdatePlaceState {}
