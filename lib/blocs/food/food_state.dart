part of 'food_bloc.dart';

class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final int placeId;
  final List<FoodModel> food;
  const FoodLoaded({
    required this.placeId,
    required this.food,
  });

  @override
  List<Object> get props => [food, placeId];
}
