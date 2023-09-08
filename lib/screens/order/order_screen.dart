import 'package:booking_app/blocs/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  final int tableNumber;
  const OrderScreen({
    super.key,
    required this.tableNumber,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OrderLoaded) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Стол ${widget.tableNumber}'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [],
                  ),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
