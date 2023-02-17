import 'package:booking_app/blocs/reservations/reservations_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class ReservationsScreen extends StatefulWidget {
  static String pageRoute = "/reservations";
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  late DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Резервации"),
      ),
      body: BlocBuilder<ReservationsBloc, ReservationsState>(
        builder: (context, state) {
          if (state is ReservationsLoading) {
            return const Center(child: CupertinoActivityIndicator(radius: 20));
          }
          if (state is ReservationsLoaded) {
            return SizedBox(
              height: 50,
              child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  // color: const Color.fromARGB(255, 59, 59, 59),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: _onDateTimeTap,
                    child: const Text(
                      "Выбрать дату",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void _onDateTimeTap() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20000)));

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
