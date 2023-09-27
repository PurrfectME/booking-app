// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/order/order_info_screen.dart';

class OrdersScreen extends StatefulWidget {
  final OrderBloc oBloc;
  final OrderInfoBloc oIBloc;
  final DishBloc dBloc;
  const OrdersScreen({
    Key? key,
    required this.oBloc,
    required this.oIBloc,
    required this.dBloc,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<OrderBloc, OrderState>(
        bloc: widget.oBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return Scaffold(
                appBar: AppBar(title: const Text('Счета')),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 400,
                    child: ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, i) {
                          final order = state.orders[i];

                          return InkWell(
                            onTap: () {
                              widget.oIBloc
                                  .add(OrderInfoLoad(orderId: order.id));

                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderInfoScreen(
                                    oBloc: widget.oIBloc,
                                    dBloc: widget.dBloc,
                                    tableNumber: order.table,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: const Color.fromARGB(255, 23, 23, 23),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Счёт №${order.id}',
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Стол №${order.table}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Row(
                                    //   children: [
                                    //     Text(order.)
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
