import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/new_app/tables/widgets/reservation_label.dart';
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
  DateTime selectedDateTime = DateTime(2023, 03, 25);

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
                        bool isYellow = false;
                        bool isRed = false;
                        UserReservationModel? nextReservation;

                        if (reservationVm.reservations.isNotEmpty) {
                          var dates = reservationVm.reservations.map((e) =>
                              DateTime.fromMillisecondsSinceEpoch(
                                  e.reservation.start));

                          final now = selectedDateTime;

                          dates = dates.where(
                              (date) => date.isAtSameDayAs(selectedDateTime));

                          final closestDateTimeToNow = dates.reduce((a, b) =>
                              a.difference(now).abs() < b.difference(now).abs()
                                  ? a
                                  : b);

                          nextReservation = reservationVm.reservations
                              .firstWhereOrNull((x) =>
                                  x.reservation.start ==
                                  closestDateTimeToNow.millisecondsSinceEpoch);

                          if (nextReservation != null) {
                            start = DateTime.fromMillisecondsSinceEpoch(
                                nextReservation.reservation.start);

                            end = DateTime.fromMillisecondsSinceEpoch(
                                nextReservation.reservation.end);

                            hasReservationsToday = true;

                            if ((start.isAtSameMomentAs(selectedDateTime) ||
                                    start.isAfter(selectedDateTime)) &&
                                end.isAfter(selectedDateTime)) {
                              if (!nextReservation.reservation.isOpened) {
                                isYellow = true;
                              } else {
                                isRed = true;
                              }
                            }
                          }
                        }

                        //TODO: сделать на стороне БД
                        // final a = reservationVm.reservations
                        //     .where((r) => !DateTime.fromMillisecondsSinceEpoch(
                        //             r.reservation.start)
                        //         .isBefore(selectedDateTime))
                        //     .toList();

                        // if (a.isNotEmpty) {
                        //   final reservation = a.first;

                        //   start = DateTime.fromMillisecondsSinceEpoch(
                        //       reservation.reservation.start);

                        //   end = DateTime.fromMillisecondsSinceEpoch(
                        //       reservation.reservation.end);

                        //   if (start.difference(selectedDateTime).inDays == 0) {
                        //     hasReservationsToday = true;

                        //     if (start.isAtSameHourAs(selectedDateTime) &&
                        //         start.isAtSameMinuteAs(selectedDateTime) &&
                        //         !reservation.reservation.isOpened) {
                        //       isYellow = true;
                        //       //добавить для брони поле, что гости уже пришли
                        //     }
                        //   }
                        // }

                        return Container(
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
                                    ReservationLabel(
                                        hasReservationsToday:
                                            hasReservationsToday,
                                        start: start,
                                        end: end),
                                    Container(
                                      width: 13,
                                      height: 13,
                                      decoration: BoxDecoration(
                                          color: isYellow
                                              ? Colors.yellowAccent
                                              : isRed
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
                                      color: isYellow
                                          ? Colors.yellowAccent
                                          : isRed
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