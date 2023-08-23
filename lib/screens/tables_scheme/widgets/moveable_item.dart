// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class MoveableStackItem extends StatefulWidget {
  double xPosition;
  double yPosition;

  MoveableStackItem({
    Key? key,
    required this.xPosition,
    required this.yPosition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  late Color color;
  @override
  void initState() {
    var a = Random().nextInt(10);
    color = a % 2 == 0 ? Colors.red : Colors.amberAccent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Positioned(
        top: widget.yPosition,
        left: widget.xPosition,
        child: GestureDetector(
          onPanUpdate: (tapInfo) {
            setState(() {
              widget.xPosition += tapInfo.delta.dx;
              widget.yPosition += tapInfo.delta.dy;
            });
          },
          child: Container(
            width: 150,
            height: 150,
            color: color,
          ),
        ),
      );
}
