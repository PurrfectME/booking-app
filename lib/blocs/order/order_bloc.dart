import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/order.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderLoading()) {
    on<OrderEvent>((event, emit) async {
      if (event is OrderLoad) {
        emit(OrderLoading());

        final order = await HiveProvider.getOrderById(event.orderId);

        emit(OrderLoaded(order: order));
      }
    });
  }
}
