import 'package:booking_app/models/db/order_item.dart';
import 'package:flutter/material.dart';

class OrderItemBox extends StatefulWidget {
  final OrderItem order;
  const OrderItemBox({
    super.key,
    required this.order,
  });

  @override
  State<OrderItemBox> createState() => _OrderItemBoxState();
}

class _OrderItemBoxState extends State<OrderItemBox> {
  @override
  Widget build(BuildContext context) => Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 2, color: const Color.fromARGB(255, 45, 45, 45)),
          color: const Color.fromARGB(255, 23, 23, 23),
        ),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                image: DecorationImage(
                    opacity: 1,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/neft.jpg')),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.order.dish.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Заметка: ${widget.order.note}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Гость: ${widget.order.guest}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
