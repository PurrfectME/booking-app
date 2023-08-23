import 'package:flutter/material.dart';

import 'widgets/moveable_item.dart';

class TablesSchemeScreen extends StatefulWidget {
  const TablesSchemeScreen({super.key});

  @override
  State<TablesSchemeScreen> createState() => _TablesSchemeScreenState();
}

class _TablesSchemeScreenState extends State<TablesSchemeScreen> {
  List<Widget> movableItems = [];

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            movableItems.add(MoveableStackItem(xPosition: 0, yPosition: 0));
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: movableItems,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  movableItems.add(MoveableStackItem(xPosition: ,));
                  setState(() {
                    xPosition += tapInfo.delta.dx;
                    yPosition += tapInfo.delta.dy;
                  });
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.amberAccent,
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.amberAccent,
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.amberAccent,
              ),
            ],
          )
        ],
      ));
}
