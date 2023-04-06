import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/reservation_info/widgets/edit_reservation_screen.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:booking_app/screens/tables/tables/widgets/reservation_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../reserve_table/reserve_table_screen.dart';

class ReservationInfoScreen extends StatefulWidget {
  final int reservationId;
  final ReservationInfoBloc reservationInfoBloc;
  const ReservationInfoScreen({
    super.key,
    required this.reservationId,
    required this.reservationInfoBloc,
  });

  @override
  State<ReservationInfoScreen> createState() => _ReservationInfoScreenState();
}

class _ReservationInfoScreenState extends State<ReservationInfoScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Заявка №${widget.reservationId}'),
        ),
        body: BlocConsumer<ReservationInfoBloc, ReservationInfoState>(
          bloc: widget.reservationInfoBloc,
          listener: (context, state) {
            if (state is ReservationInfoUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Успешно обновлено')),
              );
            }
          },
          builder: (context, state) {
            if (state is ReservationInfoLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is ReservationInfoLoaded) {
              final Color color;
              switch (state.data.status) {
                case ReservationStatus.fresh:
                  color = Colors.blueAccent;
                  break;
                case ReservationStatus.opened:
                  color = Colors.greenAccent;
                  break;
                case ReservationStatus.waiting:
                  color = Colors.yellowAccent;
                  break;
                case ReservationStatus.cancelled:
                  color = Colors.grey;
                  break;
                default:
                  color = Colors.grey;
              }

              final reservation = state.data;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReservationLabel(
                          hasReservationsToday:
                              reservation.status != ReservationStatus.cancelled,
                          start: reservation.start,
                          end: reservation.end,
                        ),
                        Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                              color:
                                  state.data.status == ReservationStatus.waiting
                                      ? Colors.yellowAccent
                                      : state.data.status ==
                                              ReservationStatus.opened
                                          ? Colors.red
                                          : Colors.green,
                              shape: BoxShape.circle),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: state.data.status == ReservationStatus.waiting
                              ? Colors.yellowAccent
                              : state.data.status == ReservationStatus.opened
                                  ? Colors.red
                                  : Colors.green,
                          shape: BoxShape.circle),
                      child:
                          Center(child: Text('Стол ${state.data.tableNumber}')),
                    ),
                    const SizedBox(height: 20),
                    Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Стол ${reservation.tableId}, Зал'),
                              Text(Status(reservation.status!).toString()),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            child: OutlinedButton(
                                onPressed: onReservationWait,
                                child: Text('Ожидать')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            child: OutlinedButton(
                                onPressed: () => onReservationOpen(
                                    state.data.placeId, state.data.start),
                                child: const Text('Открыть')),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            child: OutlinedButton(
                                onPressed: onReservationTableReplace,
                                child: Text('Заменить стол')),
                          ),
                        ),
                        if (reservation.status == ReservationStatus.opened)
                          Expanded(
                            child: Container(
                              height: 60,
                              child: OutlinedButton(
                                  onPressed: onReservationClose,
                                  child: const Text('Закрыть')),
                            ),
                          ),
                        if (reservation.status == ReservationStatus.fresh ||
                            reservation.status == ReservationStatus.waiting)
                          Expanded(
                            child: Container(
                                height: 60,
                                child: OutlinedButton(
                                    onPressed: () =>
                                        onReservationCancel(state.data.placeId),
                                    child: const Text('Отменить'))),
                          ),
                      ],
                    ),
                    OutlinedButton(
                        onPressed: onReservationEdit,
                        child: Text('Редактировать заявку'))
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  void onReservationOpen(int placeId, DateTime start) {
    final now = DateTime.now();
    if (now.isBefore(start)) {
      final difference = DateTime.fromMillisecondsSinceEpoch(
          start.difference(now).inMilliseconds);
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Открыть заявку раньше на ${difference.hour == 0 ? '' : '${DateFormat('HH', 'RU').format(difference)} ч.'} ${difference.minute == 0 ? '' : '${DateFormat('mm', 'RU').format(difference)} м.'}',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              child: const Text('Да'),
              onPressed: () {
                widget.reservationInfoBloc.add(ReservationOpen(
                    placeId: placeId,
                    reservationId: widget.reservationId,
                    start: DateTime.now().millisecondsSinceEpoch));

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Нет'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      //заявка уже в статусе ожидания => просто открываем её
      widget.reservationInfoBloc.add(ReservationOpen(
        placeId: placeId,
        reservationId: widget.reservationId,
      ));
    }
  }

  void onReservationClose() {}

  void onReservationCancel(int placeId) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Вы точно хотите отменить заявку?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            child: const Text('Да'),
            onPressed: () {
              widget.reservationInfoBloc.add(ReservationCancel(
                placeId: placeId,
                reservationId: widget.reservationId,
              ));

              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Нет'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void onReservationEdit() {
    Navigator.push<void>(
        context,
        MaterialPageRoute(
            builder: (context) => EditReservationScreen(
                  reservationId: widget.reservationId,
                  riBloc: widget.reservationInfoBloc,
                  // reservationsBloc: widget.reservationsBloc,
                  // reserveTableBloc: rtBloc,
                  // tableInfoBloc: tiBloc,
                )));
  }

  void onReservationTableReplace() {}

  void onReservationWait() {}
}
