import 'package:bloc/bloc.dart';
import 'package:booking_app/models/db/order.dart';
import 'package:booking_app/models/db/order_item.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'order_info_event.dart';
part 'order_info_state.dart';

class OrderInfoBloc extends Bloc<OrderInfoEvent, OrderInfoState> {
  List<OrderItem> orderItems = [];
  Order? order;

  OrderInfoBloc() : super(OrderInfoLoading()) {
    on<OrderInfoEvent>((event, emit) async {
      if (event is OrderInfoLoad) {
        emit(OrderInfoLoading());

        order = await HiveProvider.getOrderById(event.orderId);

        emit(OrderInfoLoaded(order: order!));
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

        emit(OrderInfoLoaded(order: order));
      } else if (event is AddItemsToOrder) {
        final dishes = await HiveProvider.getDishesByIds(event.selectedItems);

        dishes
            .map(
              (x) => order!.items.add(OrderItem(
                  id: 0,
                  createDate: DateTime.now().millisecondsSinceEpoch,
                  note: "note",
                  waiter: "waiter",
                  guest: 1,
                  dish: x)),
            )
            .toList();

        emit(OrderInfoLoaded(order: order!));
      } else if (event is EditOrderItem) {
        order!.items.firstWhere((x) => x.dish.id == event.dishId).note =
            event.note;
      } else if (event is SaveOrder) {
        if (orderItems.isNotEmpty) {
          order?.items.addAll(orderItems);

          await order?.save();

          emit(OrderPrinted());

          emit(OrderInfoLoaded(order: order!));
        }
      } else if (event is RemoveOrderItem) {
        order!.items.removeWhere((x) => x.id == event.id);

        emit(OrderInfoLoaded(order: order!));
      }
    });
  }
}
