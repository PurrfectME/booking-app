// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dish_bloc.dart';

class DishEvent extends Equatable {
  const DishEvent();

  @override
  List<Object> get props => [];
}

class DishLoad extends DishEvent {
  final int placeId;
  const DishLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class CreateDish extends DishEvent {
  final CreateFoodModel model;
  const CreateDish({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}
