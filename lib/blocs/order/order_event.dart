// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {
  final int orderId;
  const OrderLoad({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class CreateOrder extends OrderEvent {
  final int tableNumber;
  final int guests;
  const CreateOrder({
    required this.tableNumber,
    required this.guests,
  });

  @override
  List<Object> get props => [tableNumber, guests];
}

class AddItemsToOrder extends OrderEvent {
  final List<int> selectedItems;
  const AddItemsToOrder({
    required this.selectedItems,
  });

  @override
  List<Object> get props => [selectedItems];
}

class EditOrderItem extends OrderEvent {
  final int dishId;
  final String note;
  const EditOrderItem({
    required this.dishId,
    required this.note,
  });

  @override
  List<Object> get props => [note, dishId];
}

class SaveOrder extends OrderEvent {}
