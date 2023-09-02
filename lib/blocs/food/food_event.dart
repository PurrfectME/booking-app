// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_bloc.dart';

class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FoodLoad extends FoodEvent {
  final int placeId;
  const FoodLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}
