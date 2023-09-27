import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:booking_app/screens/tables/tables/widgets/reservation_label.dart';
import 'package:booking_app/screens/tables/tables/widgets/table_status.dart';
import 'package:booking_app/utils/status_helper.dart';
import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesScreen extends StatefulWidget {
  final ReservationsBloc rBloc;
  final TableReservationsBloc trBloc;
  final TablesBloc tBloc;
  final OrderInfoBloc oBloc;
  const TablesScreen({
    Key? key,
    required this.rBloc,
    required this.trBloc,
    required this.tBloc,
    required this.oBloc,
  }) : super(key: key);

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  DateTime selectedDateTime = DateTime.now();

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Столы'),
          actions: [
            BlocBuilder<TableReservationsBloc, TableReservationsState>(
              bloc: widget.trBloc,
              builder: (context, state) {
                if (state is TableReservationsLoaded) {
                  return Row(
                    children: [
                      if (state.data.isNotEmpty)
                        IconButton(
                            onPressed: () => _onReservationsTap(
                                state.data.first.table.placeId),
                            icon: Icon(Icons.request_page, color: Colors.black))
                      else
                        const SizedBox.shrink(),
                      TextButton(
                          onPressed: () {
                            widget.tBloc.add(CreateTableLoad());
                            Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => CreateTableScreen(
                                          tBloc: widget.tBloc,
                                          trBloc: widget.trBloc,
                                        )));
                          },
                          child: const Text('Создать стол',
                              style: TextStyle(color: Colors.white))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => EditSchemeBloc()
                                            ..add(EditSchemeLoad()),
                                          child: TablesSchemeScreen(
                                              oBloc: widget.oBloc),
                                        )));
                          },
                          child: const Text('Схема')),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            IconButton(
                onPressed: _onDateTimeTap,
                icon: Icon(Icons.calendar_month, color: Colors.black))
          ],
        ),
        body: BlocConsumer<TableReservationsBloc, TableReservationsState>(
          bloc: widget.trBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TableReservationsLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is TableReservationsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      // shrinkWrap: false,
                      childAspectRatio: 0.931,
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 5,
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
                              DateTime.fromMillisecondsSinceEpoch(e.start));

                          final now = selectedDateTime;

                          dates = dates.where(
                              (date) => date.isAtSameDayAs(selectedDateTime));

                          if (dates.isNotEmpty) {
                            final closestDateTimeToNow = dates.reduce((a, b) =>
                                a.difference(now).abs() <
                                        b.difference(now).abs()
                                    ? a
                                    : b);

                            final a = reservationVm.reservations
                                .firstWhereOrNull((x) =>
                                    x.start ==
                                    closestDateTimeToNow
                                        .millisecondsSinceEpoch);
                            if (a != null) {
                              if (a.userId == null) {
                                nextReservation = UserReservationModel(
                                    user: null, reservation: a);
                              } else {
                                HiveProvider.getUserById(a.userId!).then(
                                    (value) => nextReservation =
                                        UserReservationModel(
                                            user: value, reservation: a));
                              }
                            }

                            if (nextReservation != null) {
                              start = DateTime.fromMillisecondsSinceEpoch(
                                  nextReservation!.reservation.start);

                              end = DateTime.fromMillisecondsSinceEpoch(
                                  nextReservation!.reservation.end);

                              hasReservationsToday = true;

                              if (StatusHelper.toStatus(nextReservation!
                                          .reservation.status) !=
                                      ReservationStatus.opened &&
                                  now.isAfter(start)) {
                                tableStatus = TableStatus.yellow;
                              }

                              if (StatusHelper.toStatus(
                                      nextReservation!.reservation.status) ==
                                  ReservationStatus.opened) {
                                tableStatus = TableStatus.red;
                              }
                            }
                          }
                        }

                        return GestureDetector(
                          onTap: () => _onTablePress(reservationVm.table),
                          child: Container(
                            width: 210,
                            height: 226,
                            constraints: const BoxConstraints(
                                maxHeight: 226, maxWidth: 210),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 45, 45, 45),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  height: 64,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 23, 23, 23),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Основной зал',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Стол',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  )),
                                              const SizedBox(width: 6),
                                              Text(
                                                '№${reservationVm.table.number}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.people,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                reservationVm.table.guests
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
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
    Navigator.push<void>(
      context,
      MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ReserveTableBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ReservationInfoBloc(
                        trBloc: widget.trBloc, rBloc: widget.rBloc),
                  ),
                  BlocProvider<TableInfoBloc>(
                    //TODO: передавать данные в сам блок
                    create: (context) => TableInfoBloc()
                      ..add(TableInfoLoad(
                        placeId: table.placeId,
                        tableId: table.id,
                      )),
                  ),
                ],
                child: TableInfoScreen(
                    tableNumber: table.number,
                    tableGuests: table.guests,
                    tableReservationsBloc: widget.trBloc),
              )),
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

  void _onReservationsTap(int placeId) {
    final now = DateTime.now();

    widget.rBloc.add(ReservationsLoad(
        placeId: placeId,
        start: DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
        end: DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch -
            1,
        status: ReservationStatus.fresh));

    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ReservationInfoBloc(
                  trBloc: widget.trBloc, rBloc: widget.rBloc),
            ),
          ],
          child: ReservationsScreen(reservationsBloc: widget.rBloc),
        ),
      ),
    );
  }
}
