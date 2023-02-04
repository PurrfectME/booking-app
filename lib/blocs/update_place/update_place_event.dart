// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_place_bloc.dart';

abstract class UpdatePlaceEvent extends Equatable {
  const UpdatePlaceEvent();

  @override
  List<Object> get props => [];
}

class UpdatePlaceLoad extends UpdatePlaceEvent {
  final int id;
  const UpdatePlaceLoad({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UpdatePlace extends UpdatePlaceEvent {
  final PlaceModel data;

  const UpdatePlace(this.data);

  @override
  List<Object> get props => [data];
}
