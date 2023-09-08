import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/edit_scheme/edit_scheme_bloc.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/background_paint.dart';
import 'widgets/table_position_wrapper.dart';

class TablesSchemeScreen extends StatefulWidget {
  const TablesSchemeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TablesSchemeScreen> createState() => _TablesSchemeScreenState();
}

class _TablesSchemeScreenState extends State<TablesSchemeScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<EditSchemeBloc, EditSchemeState>(
        listener: (context, state) {
          if (state is SchemeSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Успешно обновлено')),
            );
          }
        },
        builder: (context, state) {
          if (state is EditSchemeLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Схема столов'),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.read<EditSchemeBloc>().add(SaveScheme());
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
                        child: _buildDropZone(state.droppedTables),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDraggableBoxes(state.availableTables),
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
    final positions = intialPositions
        .map((x) => Positioned(
              top: x.position.y,
              left: x.position.x,
              child: InkWell(
                onTap: () async {
                  await showConfirmationDialog(context, x.position.number);
                },
                child: Draggable<TablePositionWrapper>(
                  data: x,
                  feedback: Container(
                    width: 50,
                    height: 50,
                    color: Constants.mainPurple.withOpacity(0.7),
                    child: Center(
                      child: Text(x.position.number.toString()),
                    ),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Constants.mainPurple,
                    child: Center(
                      child: Text(x.position.number.toString()),
                    ),
                  ),
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
          if (intialPositions.isNotEmpty &&
              intialPositions.indexWhere((x) =>
                      x.position.number == details.data.position.number) !=
                  -1) {
            context.read<EditSchemeBloc>().add(DragTable(
                position: details.data.position,
                x: details.offset.dx,
                y: details.offset.dy));
          } else {
            context.read<EditSchemeBloc>().add(AddTable(
                position: details.data.position,
                x: details.offset.dx,
                y: details.offset.dy));
          }
        },
      ),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context, int number) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Подтверждение"),
        content: Text("Открыть счёт?"),
        actions: <Widget>[
          TextButton(
            child: Text("Нет"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text("Да"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    if (result == null) {
      return null;
    }

    //TODO: create order here
    context.read<EditSchemeBloc>().add(OpenTable(number: number));
  }

  Widget _buildDraggableBoxes(List<TableModel> tablesToMove) => SizedBox(
        height: 100,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tablesToMove.map(_buildDraggableBox).toList()),
      );

  Widget _buildDraggableBox(TableModel item) => Draggable<TablePositionWrapper>(
      key: UniqueKey(),
      data: TablePositionWrapper(
          position: TablePosition(
            active: false,
            id: 0,
            number: item.number,
            x: 0,
            y: 0,
            guests: item.guests,
            vip: 0,
          ),
          key: UniqueKey()),
      feedback: Container(
        width: 50,
        height: 50,
        color: Constants.mainPurple.withOpacity(0.7),
      ),
      child: Container(
        width: 50,
        height: 50,
        color: Constants.mainPurple,
        child: Center(
          child: Text(item.number.toString()),
        ),
      ));
}
