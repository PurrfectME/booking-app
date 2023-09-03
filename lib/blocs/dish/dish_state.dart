// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dish_bloc.dart';

class DishState extends Equatable {
  const DishState();

  @override
  List<Object> get props => [];
}

class DishLoading extends DishState {}

class DishLoaded extends DishState {
  final List<DishModel> dishes;
  final List<IngredientModel> ingredients;
  const DishLoaded({
    required this.dishes,
    required this.ingredients,
  });

  @override
  List<Object> get props => [dishes, ingredients];
}
