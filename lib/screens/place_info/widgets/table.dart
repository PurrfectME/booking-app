import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TableInfo extends StatelessWidget {
  const TableInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => onTap(place),
      child: Container(
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
              children: [
                Text(
                  "Стол 1",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Мест: ${10}",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )),
    );
    ;
  }
}
