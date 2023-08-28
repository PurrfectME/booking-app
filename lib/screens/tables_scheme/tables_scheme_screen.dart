import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/background_paint.dart';
import 'widgets/table_position_wrapper.dart';

class TablesSchemeScreen extends StatefulWidget {
  final TablesBloc tBloc;
  final int placeId;
  const TablesSchemeScreen({
    Key? key,
    required this.tBloc,
    required this.placeId,
  }) : super(key: key);

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

  List<TablePositionWrapper> droppedRectangles = [];

  @override
  Widget build(BuildContext context) => BlocConsumer<TablesBloc, TablesState>(
        bloc: widget.tBloc,
        listener: (context, state) {
          if (state is TablesPositionsUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Успешно обновлено')),
            );
          }
        },
        builder: (context, state) {
          if (state is TablesPositionsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Схема столов'),
                actions: [
                  TextButton(
                      onPressed: () {
                        final local = [...droppedRectangles];
                        droppedRectangles.clear();

                        widget.tBloc.add(SaveTablesPositions(positions: [
                          ...local.map((x) => x.position),
                        ]));
                      },
                      child: const Text('Сохранить схему',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomPaint(
                        painter: BackgroundPaint(),
                        child: _buildDropZone(state.positions),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDraggableBoxes(),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget _buildDropZone(List<TablePositionWrapper> intialPositions) {
    intialPositions
        .skipWhile(
            (value) => droppedRectangles.any((el) => el.key == value.key))
        .map((x) => droppedRectangles
            .add(TablePositionWrapper(key: x.key, position: x.position)))
        .toList();

    final positions = droppedRectangles
        .map((x) => Positioned(
              top: x.position.y,
              left: x.position.x,
              child: Draggable<TablePositionWrapper>(
                data: x,
                feedback: Container(
                  width: 50,
                  height: 50,
                  color: Color(x.position.color).withOpacity(0.7),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Color(x.position.color),
                ),
              ),
            ))
        .toList();

    return Container(
      child: DragTarget<TablePositionWrapper>(
        builder: (context, candidateData, rejectedData) => Stack(
          children: positions,
        ),
        //TODO: add onLeave event
        onWillAccept: (data) => true,
        onAcceptWithDetails: (details) {
          setState(() {
            if (droppedRectangles.isNotEmpty) {
              droppedRectangles
                ..removeWhere((x) => x.key == details.data.key)
                ..add(TablePositionWrapper(
                    key: details.data.key,
                    position: TablePosition(
                        id: 0,
                        tableId: 1,
                        placeId: widget.placeId,
                        x: details.offset.dx,
                        y: details.offset.dy - 55,
                        color: details.data.position.color)));

              return;
            }

            droppedRectangles.add(TablePositionWrapper(
                key: UniqueKey(),
                position: TablePosition(
                    id: 0,
                    tableId: 1,
                    placeId: widget.placeId,
                    x: details.offset.dx,
                    y: details.offset.dy - 55,
                    color: details.data.position.color)));
          });
        },
      ),
    );
  }

  Widget _buildDraggableBoxes() => SizedBox(
        height: 100,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: containersBox.map(_buildDraggableBox).toList()),
      );

  Widget _buildDraggableBox(Container item) => Draggable<TablePositionWrapper>(
      key: UniqueKey(),
      data: TablePositionWrapper(
          key: UniqueKey(),
          position: TablePosition(
              id: 0,
              tableId: 0,
              placeId: widget.placeId,
              x: 0,
              y: 0,
              color: item.color!.value)),
      feedback: Container(
        width: 50,
        height: 50,
        color: item.color?.withOpacity(0.7),
      ),
      child: Container(width: 50, height: 50, color: item.color));
}
