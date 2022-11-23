import 'dart:ui';

import 'package:flutter/material.dart';

class TableInfo extends StatelessWidget {
  final bool isReserved;
  const TableInfo({super.key, required this.isReserved});

  @override
  Widget build(BuildContext context) {
    return isReserved
        ? Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/neft.jpg"),
                  colorFilter:
                      ColorFilter.mode(Colors.grey, BlendMode.modulate),
                  fit: BoxFit.cover),
              color: Colors.teal[900],
            ),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          )
        : Container(
            // margin: const EdgeInsets.all(5.0),
            // width: 300,
            // height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 1,
                    image: AssetImage("assets/images/neft.jpg"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Стол 1",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Text(
                    "Мест: ${10}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
  }
}
