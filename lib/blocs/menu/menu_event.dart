// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'menu_bloc.dart';

class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class MenuLoad extends MenuEvent {
  final int placeId;
  const MenuLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class CreateCategory extends MenuEvent {
  final String name;
  final int placeId;
  const CreateCategory({
    required this.name,
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId, name];
}

class FoodLoad extends MenuEvent {
  final int placeId;
  const FoodLoad({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}

class CreateFood extends MenuEvent {
  final int placeId;
  final CreateFoodModel model;
  const CreateFood({
    required this.placeId,
    required this.model,
  });

  @override
  List<Object> get props => [placeId, model];
}
