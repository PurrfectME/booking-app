import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/db/reservation_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ReservationCard extends StatefulWidget {
  final TableModel tableModel;
  final DateTime selectedDateTime;
  final ReservationModel? currentReservation;
  final List<ReservationModel> allReservations;
  final bool isReserved;
  const ReservationCard(
      {super.key,
      required this.tableModel,
      required this.selectedDateTime,
      required this.currentReservation,
      required this.isReserved,
      required this.allReservations});

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
            InkWell(
              onTap: () => _onCardTap(widget.allReservations),
              child: Container(
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
                        Text('Гостей: ${widget.currentReservation?.guests}',
                            style: const TextStyle(color: Colors.white)),
                        Text(
                            'Время: ${DateTime.fromMillisecondsSinceEpoch(widget.currentReservation!.start).hour} : ${DateTime.fromMillisecondsSinceEpoch(widget.currentReservation!.start).minute}',
                            style: const TextStyle(color: Colors.white)),
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
                        Text(
                          '$currentGuestsCount',
                          style: const TextStyle(color: Colors.white),
                        ),
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
                  if (widget.currentReservation == null)
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

  void _onCardTap(List<ReservationModel> reservations) {
    final filteredReservations = reservations
        .where(
            (reserv) => reserv.start >= DateTime.now().millisecondsSinceEpoch)
        .toList();

    filteredReservations.sort((a, b) => a.start.compareTo(b.start));

    showBarModalBottomSheet<void>(
        context: context,
        builder: (context) => filteredReservations.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 24),
                itemCount: filteredReservations.length,
                itemBuilder: (context, index) {
                  final reservation = filteredReservations[index];
                  return Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: const Color.fromARGB(255, 59, 59, 59),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Гостей: ${reservation.guests}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text(
                                      'Время: ${DateTime.fromMillisecondsSinceEpoch(reservation.start).hour} : ${DateTime.fromMillisecondsSinceEpoch(reservation.start).minute}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                              SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.yellow),
                                  ),
                                  onPressed: () =>
                                      _removeReservation(reservation.id!),
                                  child: const Text(
                                    'Отменить бронь',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
            : const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                    child: Text(
                  'Нет броней',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
              ));
  }

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

  void _removeReservation(int reservationId) {}

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
