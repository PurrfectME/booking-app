import 'package:booking_app/utils/ext.dart';
import 'package:flutter/material.dart';

import 'widgets/moveable_item.dart';

class TablesSchemeScreen extends StatefulWidget {
  const TablesSchemeScreen({super.key});

  @override
  State<TablesSchemeScreen> createState() => _TablesSchemeScreenState();
}

class _TablesSchemeScreenState extends State<TablesSchemeScreen> {
  var containersBox = [
    Container(
      width: 50,
      height: 50,
      color: Colors.red,
    ),
    Container(
      width: 50,
      height: 50,
      color: Colors.yellowAccent,
    ),
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
        child: DragTarget<Container>(
          builder: (context, candidateData, rejectedData) => Stack(
            children: droppedRectangles,
          ),
          onWillAccept: (data) => true,
          onAcceptWithDetails: (details) {
            setState(() {
              if (droppedRectangles.isNotEmpty) {
                var toRemove = droppedRectangles.removeWhere((x) {
                  var draggableChild = x.child as Draggable<Container>;
                  if (draggableChild.data?.key == details.data.key) {
                    return true;
                  } else {
                    return false;
                  }
                });
              }

              var uniqueData = Container(
                key: UniqueKey(),
                width: 50,
                height: 50,
                color: details.data.color,
              );

              droppedRectangles.add(
                Positioned(
                  left: details.offset.dx,
                  top: details.offset.dy - 50,
                  child: Draggable<Container>(
                    key: UniqueKey(),
                    data: uniqueData,
                    feedback: Container(
                      width: 50,
                      height: 50,
                      color: details.data.color?.withOpacity(0.7),
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: details.data.color,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      );

  Widget _buildDraggableBoxes() => Container(
        height: 100,
        child: Row(children: containersBox.map(_buildDraggableBox).toList()),
      );

  Widget _buildDraggableBox(Container item) {
    return Draggable<Container>(
        key: UniqueKey(),
        data: item,
        feedback: Container(
          width: 50,
          height: 50,
          color: item.color?.withOpacity(0.7),
        ),
        child: item);
  }
}
