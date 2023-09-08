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
