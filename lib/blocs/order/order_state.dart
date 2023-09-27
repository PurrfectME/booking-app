part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  const OrdersLoaded({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}
