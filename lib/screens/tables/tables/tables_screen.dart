import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/table_info/table_info_screen.dart';
import 'package:booking_app/screens/tables/tables/widgets/reservation_label.dart';
import 'package:booking_app/screens/tables/tables/widgets/table_status.dart';
import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  // DateTime n = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Столы'),
          actions: [
            IconButton(
                onPressed: null, icon: Icon(Icons.edit, color: Colors.black)),
            IconButton(
                onPressed: _onDateTimeTap,
                icon: Icon(Icons.calendar_month, color: Colors.black))
          ],
        ),
        body: BlocConsumer<ReservationsBloc, ReservationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ReservationsLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is ReservationsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      // shrinkWrap: false,
                      childAspectRatio: 0.931,
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      primary: false,
                      children: state.data.map((reservationVm) {
                        DateTime? start;
                        DateTime? end;
                        var hasReservationsToday = false;
                        var tableStatus = TableStatus.green;
                        UserReservationModel? nextReservation;

                        //TODO: сделать на стороне БД?
                        //TODO: вытягивать резервации актуальные
                        if (reservationVm.reservations.isNotEmpty) {
                          var dates = reservationVm.reservations.map((e) =>
                              DateTime.fromMillisecondsSinceEpoch(
                                  e.reservation.start));

                          final now = selectedDateTime;

                          dates = dates.where(
                              (date) => date.isAtSameDayAs(selectedDateTime));

                          if (dates.isNotEmpty) {
                            final closestDateTimeToNow = dates.reduce((a, b) =>
                                a.difference(now).abs() <
                                        b.difference(now).abs()
                                    ? a
                                    : b);

                            nextReservation = reservationVm.reservations
                                .firstWhereOrNull((x) =>
                                    x.reservation.start ==
                                    closestDateTimeToNow
                                        .millisecondsSinceEpoch);

                            if (nextReservation != null) {
                              start = DateTime.fromMillisecondsSinceEpoch(
                                  nextReservation.reservation.start);

                              end = DateTime.fromMillisecondsSinceEpoch(
                                  nextReservation.reservation.end);

                              hasReservationsToday = true;

                              if (!nextReservation.reservation.isOpened &&
                                  now.isAfter(start)) {
                                tableStatus = TableStatus.yellow;
                              }

                              if (nextReservation.reservation.isOpened) {
                                tableStatus = TableStatus.red;
                              }

                              // if ((start.isAtSameMomentAs(now) || start.isAfter(now)) &&
                              //     end.isAfter(now)) {
                              //   if (!nextReservation.isOpened && start) {
                              //     tableStatus = TableStatus.yellow;
                              //   } else {
                              //     tableStatus = TableStatus.red;
                              //   }
                              // }
                            }
                          }
                        }

                        return GestureDetector(
                          onTap: () => _onTablePress(reservationVm.table),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //TODO: передавать статус стола и отображать корреткный лейбл
                                      ReservationLabel(
                                          hasReservationsToday:
                                              hasReservationsToday,
                                          start: start,
                                          end: end),
                                      Container(
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                            color: tableStatus ==
                                                    TableStatus.yellow
                                                ? Colors.yellowAccent
                                                : tableStatus == TableStatus.red
                                                    ? Colors.red
                                                    : Colors.green,
                                            shape: BoxShape.circle),
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: tableStatus == TableStatus.yellow
                                            ? Colors.yellowAccent
                                            : tableStatus == TableStatus.red
                                                ? Colors.red
                                                : Colors.green,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Зал'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Стол ${reservationVm.table.number}'),
                                            Row(
                                              children: [
                                                Text(reservationVm.table.guests
                                                    .toString()),
                                                const Icon(Icons.people),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }

  void _onTablePress(TableModel table) {
    final reservationsBloc = context.read<ReservationsBloc>();
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => TableInfoBloc()
            ..add(TableInfoLoad(placeId: table.placeId, tableId: table.id)),
          child: TableInfoScreen(
            tableNumber: table.number,
            tableGuests: table.guests,
            reservationsBloc: reservationsBloc,
          ),
        ),
      ),
    );
  }

  Future _onDateTimeTap() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now().toLocal(),
        firstDate: DateTime.now().toLocal(),
        lastDate: DateTime.now().toLocal().add(const Duration(days: 20000)));

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
      if (time != null) {
        setState(() {
          selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }
}

// VerticalWeightSlider(
                  //   haptic: Haptic.none,
                  //   isVertical: false,
                  //   controller: WeightSliderController(
                  //       initialWeight: 0,
                  //       minWeight: 0,
                  //       interval: 0.1,
                  //       itemExtent: 15),
                  //   decoration: const PointerDecoration(
                  //     width: 130.0,
                  //     height: 3.0,
                  //     largeColor: Color.fromARGB(255, 0, 0, 0),
                  //     mediumColor: Color(0xFFC5C5C5),
                  //     smallColor: Color.fromARGB(255, 41, 171, 134),
                  //     gap: 40.0,
                  //   ),
                  //   onChanged: (double value) {
                  //     setState(() {
                  //       // _weight = value;
                  //     });
                  //   },
                  //   indicator: Container(
                  //     height: 3.0,
                  //     width: 200.0,
                  //     alignment: Alignment.centerLeft,
                  //     color: Colors.red[300],
                  //   ),
                  // ),

                  // HorizontalPicker(
                  //   height: 140,
                  //   minValue: 0,
                  //   maxValue: 23,
                  //   divisions: 252,
                  //   // showCursor: true,
                  //   backgroundColor: Colors.grey.shade900,
                  //   activeItemTextColor: Colors.white,
                  //   passiveItemsTextColor: Colors.amber,
                  //   onChanged: (value) {},
                  // ),