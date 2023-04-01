import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/reserve_table/reserve_table_screen.dart';
import 'package:booking_app/screens/tables/tables/widgets/reservation_label.dart';
import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../tables/tables/widgets/table_status.dart';

class TableInfoScreen extends StatefulWidget {
  static const String pageRoute = '/tableInfo';
  final int tableNumber;
  final int tableGuests;
  final ReservationsBloc reservationsBloc;
  const TableInfoScreen({
    super.key,
    required this.tableNumber,
    required this.tableGuests,
    required this.reservationsBloc,
  });

  @override
  State<TableInfoScreen> createState() => _TableInfoScreenState();
}

class _TableInfoScreenState extends State<TableInfoScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Стол ${widget.tableNumber}'),
        ),
        body: BlocConsumer<TableInfoBloc, TableInfoState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TableInfoLoading) {
                return const Center(
                    child: CupertinoActivityIndicator(radius: 20));
              } else if (state is TableInfoLoaded) {
                DateTime? start;
                DateTime? end;
                var hasReservationsToday = false;
                var tableStatus = TableStatus.green;
                ReservationModel? nextReservation;

                //TODO: сделать на стороне БД?
                //TODO: вытягивать резервации актуальные
                if (state.data.reservations.isNotEmpty) {
                  var dates = state.data.reservations
                      .map((e) => DateTime.fromMillisecondsSinceEpoch(e.start));

                  final now = DateTime.now();

                  dates = dates.where((date) => date.isAtSameDayAs(now));

                  if (dates.isNotEmpty) {
                    final closestDateTimeToNow = dates.reduce((a, b) =>
                        a.difference(now).abs() < b.difference(now).abs()
                            ? a
                            : b);

                    nextReservation = state.data.reservations.firstWhereOrNull(
                        (x) =>
                            x.start ==
                            closestDateTimeToNow.millisecondsSinceEpoch);

                    if (nextReservation != null) {
                      start = DateTime.fromMillisecondsSinceEpoch(
                          nextReservation.start);

                      end = DateTime.fromMillisecondsSinceEpoch(
                          nextReservation.end);

                      hasReservationsToday = true;

                      if (!nextReservation.isOpened && now.isAfter(start)) {
                        tableStatus = TableStatus.yellow;
                      }

                      if (nextReservation.isOpened) {
                        tableStatus = TableStatus.red;
                      }
                    }
                  }
                }

                return Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(99, 27, 27, 27)),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReservationLabel(
                                    hasReservationsToday: hasReservationsToday,
                                    start: hasReservationsToday ? start : null,
                                    end: hasReservationsToday ? end : null),
                                Container(
                                  width: 13,
                                  height: 13,
                                  decoration: BoxDecoration(
                                      color: tableStatus == TableStatus.yellow
                                          ? Colors.yellowAccent
                                          : tableStatus == TableStatus.red
                                              ? Colors.red
                                              : Colors.green,
                                      shape: BoxShape.circle),
                                )
                              ],
                            ),
                            Center(
                              child: Container(
                                width: 70,
                                height: 70,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: tableStatus == TableStatus.yellow
                                        ? Colors.yellowAccent
                                        : tableStatus == TableStatus.red
                                            ? Colors.red
                                            : Colors.green,
                                    shape: BoxShape.circle),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(widget.tableGuests.toString()),
                                const Icon(
                                  Icons.people,
                                  size: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.data.reservations.length,
                          itemBuilder: (context, i) {
                            final start = DateTime.fromMillisecondsSinceEpoch(
                                state.data.reservations[i].start);
                            final end = DateTime.fromMillisecondsSinceEpoch(
                                state.data.reservations[i].end);

                            var reservationNumber = ++i;
                            return Text(
                              'Бронь №$reservationNumber: с ${DateFormat('HH:mm').format(start)} до ${DateFormat('HH:mm').format(end)}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => ReserveTableBloc(
                                              reservationsBloc:
                                                  widget.reservationsBloc,
                                              tableInfoBloc: context.read())
                                            ..add(ReserveTableLoad(
                                                tableId: state.data.table.id,
                                                placeId:
                                                    state.data.table.placeId)),
                                          child: ReserveTableScreen(
                                              tableNumber:
                                                  state.data.table.number),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Забронировать',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 13, left: 13, right: 13),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  onPressed: null,
                                  child: const Text(
                                    'По факту',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      );
}
