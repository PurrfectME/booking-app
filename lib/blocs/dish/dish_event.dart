// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dish_bloc.dart';

class DishEvent extends Equatable {
  const DishEvent();

  @override
  List<Object> get props => [];
}

class DishLoad extends DishEvent {
  const DishLoad();

  @override
  List<Object> get props => [];
}

class CreateDish extends DishEvent {
  final CreateDishModel model;
  const CreateDish({
    required this.model,
  });

  @override
  List<Object> get props => [model];
}
