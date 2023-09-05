// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kitchen_bloc.dart';

class KitchenEvent extends Equatable {
  const KitchenEvent();

  @override
  List<Object> get props => [];
}

class KitchenLoad extends KitchenEvent {}

class CreateKitchenItem extends KitchenEvent {
  final KitchenModel kitchen;
  const CreateKitchenItem({
    required this.kitchen,
  });

  @override
  List<Object> get props => [kitchen];
}
