// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_info_bloc.dart';

class OrderInfoEvent extends Equatable {
  const OrderInfoEvent();

  @override
  List<Object> get props => [];
}

class OrderInfoLoad extends OrderInfoEvent {
  final int orderId;
  const OrderInfoLoad({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}

class CreateOrder extends OrderInfoEvent {
  final int tableNumber;
  final int guests;
  const CreateOrder({
    required this.tableNumber,
    required this.guests,
  });

  @override
  List<Object> get props => [tableNumber, guests];
}

class AddItemsToOrder extends OrderInfoEvent {
  final List<int> selectedItems;
  const AddItemsToOrder({
    required this.selectedItems,
  });

  @override
  List<Object> get props => [selectedItems];
}

class EditOrderItem extends OrderInfoEvent {
  final int dishId;
  final String note;
  const EditOrderItem({
    required this.dishId,
    required this.note,
  });

  @override
  List<Object> get props => [note, dishId];
}

class SaveOrder extends OrderInfoEvent {}

class RemoveOrderItem extends OrderInfoEvent {
  final int id;
  const RemoveOrderItem({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
