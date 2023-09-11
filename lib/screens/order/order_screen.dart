import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/screens/order/widgets/order_item.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  final int tableNumber;
  final OrderBloc oBloc;
  final DishBloc dBloc;
  const OrderScreen({
    super.key,
    required this.tableNumber,
    required this.oBloc,
    required this.dBloc,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<OrderBloc, OrderState>(
        bloc: widget.oBloc,
        listener: (context, state) {
          if (state is OrderPrinted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Отправлено')),
            );
          }
        },
        builder: (context, state) {
          if (state is OrderLoaded) {
            return Scaffold(
                floatingActionButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder()),
                  onPressed: _saveOrder,
                  child: const Text('Сохранить счёт'),
                ),
                appBar: AppBar(
                  title: Text('Стол ${widget.tableNumber}'),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: () async => await _addOrderItems(),
                      child: const Text('Добавить блюдо в счёт'),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Название',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Гость',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Официант',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Заметка',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: state.order.items
                          .map(
                            (x) => DataRow(
                              cells: [
                                DataCell(Text(x.dish.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                                DataCell(Text(x.guest.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                                DataCell(Text(x.waiter,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                                DataCell(
                                  TextField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Constants.mainPurple,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 66, 66, 66),
                                            width: 2),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      widget.oBloc.add(EditOrderItem(
                                        note: value,
                                        dishId: x.dish.id,
                                      ));
                                    },
                                  ),
                                  // controller: amountControllers[x.name],
                                ),
                              ],
                            ),
                          )
                          .toList()),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _saveOrder() {
    widget.oBloc.add(SaveOrder());
  }

  Future _addOrderItems() async {
    final selectedItems = await Navigator.push<List<int>>(
      context,
      MaterialPageRoute(
        builder: (context) => DishScreen(
          dBloc: widget.dBloc,
          isSelectable: true,
        ),
      ),
    );

    if (selectedItems == null || selectedItems.isEmpty) {
      return null;
    }

    widget.oBloc.add(AddItemsToOrder(selectedItems: selectedItems));
  }
}
