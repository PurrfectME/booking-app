import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:booking_app/screens/tables/tables/widgets/reservation_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReservationInfoScreen extends StatefulWidget {
  final int reservationId;
  const ReservationInfoScreen({super.key, required this.reservationId});

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
          listener: (context, state) {},
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
                default:
                  color = Colors.grey;
              }

              final reservation = state.data;

              return Column(
                children: [
                  ReservationLabel(
                    hasReservationsToday: true,
                    start: reservation.start,
                    end: reservation.end,
                  ),
                  Padding(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Стол ${reservation.tableId}, Зал'),
                              Text(Status(reservation.status).toString()),
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
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
}
