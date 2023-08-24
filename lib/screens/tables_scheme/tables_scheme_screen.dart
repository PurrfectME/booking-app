import 'package:flutter/material.dart';

import 'widgets/moveable_item.dart';

class TablesSchemeScreen extends StatefulWidget {
  const TablesSchemeScreen({super.key});

  @override
  State<TablesSchemeScreen> createState() => _TablesSchemeScreenState();
}

class _TablesSchemeScreenState extends State<TablesSchemeScreen> {
  List<Color> boxColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  List<Positioned> droppedRectangles = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Drag and Drop Rectangles')),
        body: Center(
          child: Column(
            children: [
              Expanded(child: _buildDropZone()),
              const SizedBox(height: 20),
              _buildDraggableBoxes(),
            ],
          ),
        ),
      );

  Widget _buildDropZone() => Container(
        color: Colors.grey,
        child: DragTarget<int>(
          builder: (context, candidateData, rejectedData) => Stack(
            children: droppedRectangles,
          ),
          onWillAccept: (data) => true,
          onAcceptWithDetails: (details) {
            setState(() {
              droppedRectangles.add(
                Positioned(
                  left: details.offset.dx,
                  top: details.offset.dy - 50,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: boxColors[details.data],
                  ),
                ),
              );
            });
          },
        ),
      );

  Widget _buildDraggableBoxes() => Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: boxColors
              .asMap()
              .map((index, color) => MapEntry(index, _buildDraggableBox(index)))
              .values
              .toList(),
        ),
      );

  Widget _buildDraggableBox(int colorIndex) {
    final color = boxColors[colorIndex];
    return Draggable<int>(
      data: colorIndex,
      feedback: Container(
        width: 50,
        height: 50,
        color: color.withOpacity(0.7),
      ),
      child: Container(
        width: 50,
        height: 50,
        color: color,
      ),
    );
  }
}
