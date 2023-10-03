import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInfoScreen extends StatefulWidget {
  final int tableNumber;
  final OrderInfoBloc oIBloc;
  final DishBloc dBloc;
  const OrderInfoScreen({
    super.key,
    required this.tableNumber,
    required this.oIBloc,
    required this.dBloc,
  });

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OrderInfoBloc, OrderInfoState>(
        bloc: widget.oIBloc,
        listener: (context, state) {
          if (state is OrderPrinted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Отправлено')),
            );
          }
        },
        builder: (context, state) {
          if (state is OrderInfoLoaded) {
            return Scaffold(
                floatingActionButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Constants.mainPurple,
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
                        DataColumn(
                          label: Text(''),
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
                                      widget.oIBloc.add(EditOrderItem(
                                        note: value,
                                        dishId: x.dish.id,
                                      ));
                                    },
                                    controller:
                                        TextEditingController(text: x.note),
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.white),
                                    onPressed: () {
                                      widget.oIBloc
                                          .add(RemoveOrderItem(id: x.id));
                                    },
                                  ),
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
    widget.oIBloc.add(SaveOrder());
  }

  Future _addOrderItems() async {
    final selectedItems = await Navigator.push<List<int>>(
      context,
      MaterialPageRoute(
        builder: (context) {
          widget.dBloc.add(const DishLoad());

          return DishScreen(
            dBloc: widget.dBloc,
            isSelectable: true,
          );
        },
      ),
    );

    if (selectedItems == null || selectedItems.isEmpty) {
      return null;
    }

    widget.oIBloc.add(AddItemsToOrder(selectedItems: selectedItems));
  }
}
