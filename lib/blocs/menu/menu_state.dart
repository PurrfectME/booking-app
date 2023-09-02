// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'menu_bloc.dart';

class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final int placeId;
  final List<CategoryModel> categories;
  const MenuLoaded({
    required this.placeId,
    required this.categories,
  });

  @override
  List<Object> get props => [placeId, categories];
}

class FoodLoaded extends MenuState {
  final int placeId;
  final List<FoodModel> food;
  const FoodLoaded({
    required this.placeId,
    required this.food,
  });

  @override
  List<Object> get props => [food, placeId];
}
