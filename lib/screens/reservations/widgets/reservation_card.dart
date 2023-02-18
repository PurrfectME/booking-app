import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationCard extends StatefulWidget {
  final TableModel tableModel;
  final DateTime selectedDateTime;
  final ReservationModel? reservationModel;
  final bool isReserved;
  const ReservationCard(
      {super.key,
      required this.tableModel,
      required this.selectedDateTime,
      required this.reservationModel,
      required this.isReserved});

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  int currentGuestsCount = 1;

  @override
  Widget build(BuildContext context) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: const Color.fromARGB(255, 59, 59, 59),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
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
                    'Столик ${widget.tableModel.number}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  if (widget.isReserved)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Гостей: ${widget.reservationModel?.guests}',
                            style: const TextStyle(color: Colors.white)),
                        Text(
                            'Время: ${DateTime.fromMillisecondsSinceEpoch(widget.reservationModel!.start).hour} : ${DateTime.fromMillisecondsSinceEpoch(widget.reservationModel!.start).minute}',
                            style: TextStyle(color: Colors.white)),
                      ],
                    )
                  else
                    Row(
                      children: [
                        IconButton(
                            splashColor: const Color.fromARGB(160, 85, 85, 85),
                            onPressed: _canDescrease(currentGuestsCount)
                                ? _onGuestsCountDecrease
                                : null,
                            icon: Icon(Icons.remove,
                                color: _canDescrease(currentGuestsCount)
                                    ? Colors.white
                                    : Colors.black)),
                        Text('$currentGuestsCount'),
                        IconButton(
                          splashColor: const Color.fromARGB(160, 85, 85, 85),
                          onPressed: _canIncrease(
                                  currentGuestsCount, widget.tableModel.guests)
                              ? _onGuestsCountIncrease
                              : null,
                          icon: Icon(Icons.add,
                              color: _canIncrease(currentGuestsCount,
                                      widget.tableModel.guests)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  if (widget.reservationModel == null)
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow),
                        ),
                        onPressed: () => _reserveTable(
                            widget.tableModel.id, widget.tableModel.placeId),
                        child: const Text(
                          'Забронировать',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  else
                    const SizedBox()
                ],
              ),
            )
          ],
        ),
      );

  void _reserveTable(int tableId, int placeId) {
    context.read<PlaceInfoBloc>().add(PlaceTableReserve(
        tableId,
        currentGuestsCount,
        placeId,
        widget.selectedDateTime,
        DateTime.now().add(
          const Duration(hours: 10),
        )));
  }

  bool _canIncrease(int reservedGuests, int maxGuests) =>
      reservedGuests < maxGuests;

  bool _canDescrease(int reservedGuests) => reservedGuests > 1;

  void _onGuestsCountDecrease() {
    setState(() {
      currentGuestsCount--;
    });
  }

  void _onGuestsCountIncrease() {
    setState(() {
      currentGuestsCount++;
    });
  }
}
