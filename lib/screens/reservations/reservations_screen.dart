import 'package:booking_app/blocs/reservations/reservations_state.dart';
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/screens/reservations/widgets/table_reservation_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/blocs.dart';

class ReservationsScreen extends StatefulWidget {
  static String pageRoute = '/reservations';
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) =>
      BlocListener<ReservationsBloc, ReservationsState>(
        listener: (context, state) {
          if (state is RemoveReservationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Бронь на ${state.tableNumber} стол отменена!')),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Резервации"),
          ),
          body: BlocBuilder<ReservationsBloc, ReservationsState>(
            builder: (context, state) {
              if (state is ReservationsLoading) {
                return const Center(
                    child: CupertinoActivityIndicator(radius: 20));
              }
              if (state is ReservationsLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: const Color.fromARGB(255, 59, 59, 59),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: _onDateTimeTap,
                          child: const Text(
                            'Выбрать дату',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(DateFormat('E, d MMM yyyy HH:mm', 'RU')
                          .format(selectedDateTime)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          // ReservationModel? reservation;
                          // if (state.data[index].reservations.isNotEmpty) {
                          //   reservation = state.data[index].reservations
                          //       .cast<ReservationModel>()
                          //       .firstWhereOrNull((res) {
                          //     var start =
                          //         DateTime.fromMillisecondsSinceEpoch(res.start);
                          //     var dif =
                          //         selectedDateTime.difference(start).inMinutes;
                          //     return dif < 0;
                          //   });
                          // }

                          return TableReservationCard(
                            tableModel: state.data[index].table,
                            selectedDateTime: selectedDateTime,
                            reservations: state.data[index].reservations,
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      );

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
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
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
