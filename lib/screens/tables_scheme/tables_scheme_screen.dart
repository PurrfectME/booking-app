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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drag and Drop Rectangles')),
      body: Center(
        child: Column(
          children: [
            _buildDraggableBoxes(),
            SizedBox(height: 20),
            Expanded(child: _buildDropZone()),
          ],
        ),
      ),
    );
  }

  Widget _buildDropZone() => Container(
        color: Colors.grey,
        child: DragTarget<int>(
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: droppedRectangles,
            );
          },
          onWillAccept: (data) {
            return true;
          },
          onAcceptWithDetails: (data) {
            setState(() {
              droppedRectangles.add(
                Positioned(
                  left: data.offset.dx,
                  top: data.offset.dy,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: boxColors[2],
                  ),
                ),
              );
            });
          },
        ),
      );

  Widget _buildDraggableBoxes() {
    return Container(
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
  }

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
