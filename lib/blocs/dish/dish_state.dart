part of 'dish_bloc.dart';

class DishState extends Equatable {
  const DishState();

  @override
  List<Object> get props => [];
}

class DishLoading extends DishState {}

class DishLoaded extends DishState {
  final List<DishModel> dishes;
  const DishLoaded({
    required this.dishes,
  });

  @override
  List<Object> get props => [dishes];
}
