part of 'order_info_bloc.dart';

class OrderInfoState extends Equatable {
  const OrderInfoState();

  @override
  List<Object> get props => [];
}

class OrderInfoLoading extends OrderInfoState {}

class OrderInfoLoaded extends OrderInfoState {
  final Order order;
  const OrderInfoLoaded({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class OrderPrinted extends OrderInfoState {}
