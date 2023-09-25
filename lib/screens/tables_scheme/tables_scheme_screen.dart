import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/edit_scheme/edit_scheme_bloc.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_order_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/tables_scheme/widgets/create_order_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/background_paint.dart';
import 'widgets/table_position_wrapper.dart';

class TablesSchemeScreen extends StatefulWidget {
  final OrderBloc oBloc;
  const TablesSchemeScreen({
    Key? key,
    required this.oBloc,
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
                    feedback: SvgPicture.asset(
                      'assets/images/table2.svg',
                      width: 75,
                      height: 75,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/table2.svg',
                      width: 75,
                      height: 75,
                    )),
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
    final result = await showDialog<CreateOrderModel>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Открыть счёт',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(width: 500, child: CreateOrderForm()),
            ));

    if (result == null) {
      return null;
    }

    widget.oBloc.add(CreateOrder(tableNumber: number, guests: result.guests));

    context.read<EditSchemeBloc>().add(OpenTable(number: number));
  }

  Widget _buildDraggableBoxes(List<TableModel> tablesToMove) => Container(
        height: 100,
        color: Colors.redAccent,
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
          width: 100,
          height: 100,
          child: SvgPicture.asset(
            'assets/images/table2.svg',
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: SvgPicture.asset(
                'assets/images/table${item.guests}.svg',
                width: 50,
                height: 100,
              ),
            ),
            Container(
                child: Center(
              child: Text(
                item.number.toString(),
                style: TextStyle(color: Colors.white),
              ),
            )),
          ],
        ),
      );
}
