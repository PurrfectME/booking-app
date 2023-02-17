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
  Widget build(BuildContext context) => Scaffold(
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
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final reservation = state.data[index].reservations.firstWhere((res) => res.start == selectedDateTime.add(Duration(minutes: 10)).millisecondsSinceEpoch);

                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        color: const Color.fromARGB(255, 59, 59, 59),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                    opacity: 1,
                                    image: AssetImage("assets/images/neft.jpg"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Столик ${state.data[index].table.number}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Мест: ${state.data[index].table.guests}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    'Депозит(VIP): 200руб.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(state.data[index].table.)
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        child: Card(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  splashColor:
                                                      const Color.fromARGB(
                                                          160, 85, 85, 85),
                                                  onPressed: _canDescrease(
                                                          currentGuestsCount)
                                                      ? _onGuestsCountDecrease
                                                      : null,
                                                  icon: Icon(Icons.remove,
                                                      color: _canDescrease(
                                                              currentGuestsCount)
                                                          ? Colors.white
                                                          : Colors.black)),
                                              Text('$currentGuestsCount'),
                                              IconButton(
                                                splashColor:
                                                    const Color.fromARGB(
                                                        160, 85, 85, 85),
                                                onPressed: _canIncrease(
                                                        currentGuestsCount,
                                                        widget
                                                            .model.table.guests)
                                                    ? _onGuestsCountIncrease
                                                    : null,
                                                icon: Icon(Icons.add,
                                                    color: _canIncrease(
                                                            currentGuestsCount,
                                                            widget.model.table
                                                                .guests)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 52,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.yellow),
                                            ),
                                            onPressed: () => context
                                                .read<PlaceInfoBloc>()
                                                .add(PlaceTableReserve(
                                                    widget.model.table.id,
                                                    currentGuestsCount,
                                                    widget.model.table.placeId,
                                                    widget.selectedDateTime,
                                                    DateTime.now().add(
                                                      const Duration(hours: 10),
                                                    ))),
                                            child: const Text(
                                              'Забронировать',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                    }
                    separatorBuilder: (context, _) =>
                        const SizedBox(height: 16),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  Future _onDateTimeTap() async {
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
