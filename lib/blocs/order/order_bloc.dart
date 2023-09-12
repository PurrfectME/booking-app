import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/order.dart';
import 'package:booking_app/models/db/order_item.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<OrderItem> orderItems = [];
  Order? order;

  OrderBloc() : super(OrderLoading()) {
    on<OrderEvent>((event, emit) async {
      if (event is OrderLoad) {
        emit(OrderLoading());

        order = await HiveProvider.getOrderById(event.orderId);

        emit(OrderLoaded(order: order!));
      } else if (event is CreateOrder) {
        //TODO: Откуда брать админа(прост юзер который залогинен скорее всего)
        final id = await HiveProvider.createOrder(Order(
          id: 0,
          table: event.tableNumber,
          openDate: DateTime.now().millisecondsSinceEpoch,
          closeDate: null,
          items: [],
          cardId: null,
          administrator: "administrator",
          guests: event.guests,
        ));

        final order = await HiveProvider.getOrderById(id);

        emit(OrderLoaded(order: order));
      } else if (event is AddItemsToOrder) {
        final dishes = await HiveProvider.getDishesByIds(event.selectedItems);

        dishes
            .map(
              (x) => orderItems.add(OrderItem(
                  id: 0,
                  createDate: DateTime.now().millisecondsSinceEpoch,
                  note: "note",
                  waiter: "waiter",
                  guest: 1,
                  dish: x)),
            )
            .toList();

        final currentOrder = Order(
            id: 0,
            table: 0,
            openDate: 1,
            closeDate: 1,
            items: orderItems,
            cardId: 1,
            administrator: "administrator",
            guests: 1);

        emit(OrderLoaded(order: currentOrder));
      } else if (event is EditOrderItem) {
        orderItems.firstWhere((x) => x.dish.id == event.dishId).note =
            event.note;
      } else if (event is SaveOrder) {
        if (orderItems.isNotEmpty) {
          order?.items.addAll(orderItems);

          await order?.save();

          emit(OrderPrinted());

          emit(OrderLoaded(order: order!));
        }
      } else {
        emit(OrderLoading());
      }
    });
  }
}
