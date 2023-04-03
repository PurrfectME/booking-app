import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/reservations/reservations_bloc.dart';

class ReservationsScreen extends StatefulWidget {
  static const String pageRoute = '/reservations';
  const ReservationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  ReservationStatus selectedStatus = ReservationStatus.fresh;
  DateTime selectedDate = DateTime.now();
  late int placeId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Заявки'),
          actions: [
            IconButton(
                onPressed: () => _onDateTimeTap(placeId),
                icon: const Icon(Icons.calendar_month)),
          ],
        ),
        body: BlocConsumer<ReservationsBloc, ReservationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ReservationsLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is ReservationsLoaded) {
              placeId = state.placeId;
              if (state.data.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Center(child: Text('Нет резерваций')),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () => onReservationStatusChange(
                                    ReservationStatus.waiting, state.placeId),
                                child: const Text('Ожидаем'))),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () => onReservationStatusChange(
                                    ReservationStatus.opened, state.placeId),
                                child: const Text('Открыты'))),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () => onReservationStatusChange(
                                    ReservationStatus.closing, state.placeId),
                                child: const Text('Закрытие'))),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () => onReservationStatusChange(
                                    ReservationStatus.fresh, state.placeId),
                                child: const Text('Новые'))),
                      ],
                    )
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: state.data.length,
                    itemBuilder: (context, i) {
                      final Color color;
                      switch (selectedStatus) {
                        case ReservationStatus.fresh:
                          color = Colors.blueAccent;
                          break;
                        case ReservationStatus.opened:
                          color = Colors.greenAccent;
                          break;
                        default:
                          color = Colors.greenAccent;
                      }

                      final reservation = state.data[i];

                      return GestureDetector(
                        onTap: () => onReservationTap(reservation.id),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: color,
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Стол ${reservation.tableId}, Зал'),
                                    Text(Status(selectedStatus).toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${reservation.name}, ${reservation.guests} чел.',
                                    ),
                                  ],
                                ),
                                Text(
                                  reservation.phoneNumber,
                                ),
                                Text(
                                  '${DateFormat('HH:mm', 'RU').format(reservation.start)} - ${DateFormat('HH:mm', 'RU').format(reservation.end)}',
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () => onReservationStatusChange(
                                  ReservationStatus.waiting, state.placeId),
                              child: const Text('Ожидаем'))),
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () => onReservationStatusChange(
                                  ReservationStatus.opened, state.placeId),
                              child: const Text('Открыты'))),
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () => onReservationStatusChange(
                                  ReservationStatus.closing, state.placeId),
                              child: const Text('Закрытие'))),
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () => onReservationStatusChange(
                                  ReservationStatus.fresh, state.placeId),
                              child: const Text('Новые'))),
                    ],
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  void onReservationTap(int reservationId) {
    context.read<ReservationInfoBloc>().add(ReservationInfoLoad(
        placeId: placeId,
        reservationId: reservationId,
        status: selectedStatus));

    Navigator.push<void>(
      context,
      MaterialPageRoute(
          builder: (context) => ReservationInfoScreen(
                reservationId: reservationId,
              )),
    );
  }

  void onReservationStatusChange(ReservationStatus status, int placeId) {
    context.read<ReservationsBloc>().add(ReservationsLoad(
        placeId: placeId,
        start: selectedDate.millisecondsSinceEpoch,
        status: status));

    setState(() {
      selectedStatus = status;
    });
  }

  Future _onDateTimeTap(int placeId) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20000)));

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
        context.read<ReservationsBloc>().add(ReservationsLoad(
            placeId: placeId,
            start: DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ).millisecondsSinceEpoch,
            status: selectedStatus));
        setState(() {
          selectedDate =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }
}

enum ReservationStatus { waiting, opened, closing, closed, fresh }

class Status {
  final ReservationStatus type;

  Status(this.type);

  @override
  String toString() {
    switch (type) {
      case ReservationStatus.waiting:
        return 'Ожидаем';
      case ReservationStatus.opened:
        return 'Открыта';
      case ReservationStatus.closed:
        return 'Закрыта';
      case ReservationStatus.closing:
        return 'Закрытие';
      case ReservationStatus.fresh:
        return 'Новая';
      default:
        return 'asd';
    }
  }
}
