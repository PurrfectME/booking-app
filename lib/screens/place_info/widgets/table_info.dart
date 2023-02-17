import 'dart:ui';

import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class TableInfo extends StatelessWidget {
  final bool isReservedByUser;
  final TableModel table;
  const TableInfo({
    super.key,
    required this.isReservedByUser,
    required this.table,
  });

  @override
  Widget build(BuildContext context) => isReservedByUser
      //move to common widget
      ? Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/neft.jpg'),
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate),
                fit: BoxFit.cover),
            color: Colors.teal[900],
          ),
          child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Text(
                              'Стол ${table.id}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Ожидание подтверждения',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        )
      : Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 1,
                  image: AssetImage('assets/images/neft.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Стол ${table.id}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'ID: ${table.id}',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
}
