
import 'package:flutter/material.dart';

class DishItem extends StatelessWidget {
  final String name;
  final double price;
  const DishItem({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) => Container(
        width: 300,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 2, color: const Color.fromARGB(255, 45, 45, 45)),
          color: const Color.fromARGB(255, 23, 23, 23),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 150,
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
            const SizedBox(width: 30),
            Container(
              // margin: const EdgeInsets.only(top: 30),
              // padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Цена: $price',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
