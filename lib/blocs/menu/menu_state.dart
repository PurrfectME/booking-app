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
  const MenuLoaded({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

// class FoodLoaded extends MenuState {
//   final int placeId;
//   final List<Dish> food;
//   const FoodLoaded({
//     required this.placeId,
//     required this.food,
//   });

//   @override
//   List<Object> get props => [food, placeId];
// }
