// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order;
  const OrderLoaded({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
