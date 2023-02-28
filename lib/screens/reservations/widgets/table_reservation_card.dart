import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TableReservationCard extends StatefulWidget {
  final TableModel tableModel;
  final DateTime selectedDateTime;
  final List<UserReservationModel> reservations;
  final UserReservationModel? nextReservation;
  const TableReservationCard(
      {super.key,
      required this.tableModel,
      required this.selectedDateTime,
      required this.reservations,
      required this.nextReservation});

  @override
  State<TableReservationCard> createState() => _TableReservationCardState();
}

class _TableReservationCardState extends State<TableReservationCard> {
  int guestsCount = 1;

  @override
  Widget build(BuildContext context) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: const Color.fromARGB(255, 59, 59, 59),
        child: SizedBox(
          height: 190,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async => await _onCardTap(widget.reservations),
                child: Container(
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
              Container(
                padding: const EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Столик ${widget.tableModel.number}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    if (widget.nextReservation == null)
                      Text('Гостей: ${widget.tableModel.guests}',
                          style: const TextStyle(color: Colors.white)),
                    if (widget.nextReservation != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Гостей: ${widget.nextReservation!.reservation.guests}',
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.nextReservation!.reservation.start))}',
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              'Гость: ${widget.nextReservation!.user.name}(${widget.nextReservation!.user.login})',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    SizedBox(
                      height: 32,
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
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Future _onCardTap(List<UserReservationModel> reservations) async {
    final filteredReservations = reservations
        .where((reserv) =>
            reserv.reservation.start >=
            widget.selectedDateTime.millisecondsSinceEpoch)
        .toList();

    // filteredReservations.addAll([
    //   filteredReservations[0],
    //   filteredReservations[0],
    //   filteredReservations[0],
    //   filteredReservations[0],
    //   filteredReservations[0]
    // ]);

    await showBarModalBottomSheet<void>(
        context: context,
        builder: (context) => filteredReservations.isNotEmpty
            ? SizedBox(
                height: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: filteredReservations.length,
                    itemBuilder: (context, index) {
                      final reservationModel = filteredReservations[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Гостей: ${reservationModel.reservation.guests}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(reservationModel.reservation.start))}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          'Гость: ${reservationModel.user.name}(${reservationModel.user.login})',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 52,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow),
                                      ),
                                      onPressed: () {
                                        _removeReservation(
                                            reservationModel.reservation.id!,
                                            reservationModel
                                                .reservation.placeId,
                                            widget.tableModel.number);
                                        // setState(() {
                                        //   widget.allReservations =
                                        // });
                                        filteredReservations.removeAt(index);
                                      },
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
                    }),
              )
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

  Future _reserveTable(int tableId, int placeId) async {
    var phoneNumber = '';
    var name = '';

    final a = await showDialog<void>(
        context: context,
        // ignore: prefer_expression_function_bodies
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Данные брони',
              style: TextStyle(color: Colors.black),
            ),
            content: SizedBox(
              height: 190,
              child: Form(
                child: Column(
                  children: [
                    Text(
                        'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(widget.selectedDateTime)}',
                        style: const TextStyle(color: Colors.black)),
                    TextFormField(
                      initialValue: '',
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Номер телефона',
                          labelStyle: TextStyle(color: Colors.black)),
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        phoneNumber = newValue!;
                      },
                      onChanged: (value) => phoneNumber = value,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    TextFormField(
                      initialValue: '',
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Имя',
                          labelStyle: TextStyle(color: Colors.black)),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        name = newValue!;
                      },
                      onChanged: (value) => name = value,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    Row(
                      children: [
                        Text('Гостей'),
                        IconButton(
                            splashColor: const Color.fromARGB(160, 85, 85, 85),
                            onPressed: _canDescrease(guestsCount)
                                ? () => setState(() {
                                      guestsCount = guestsCount--;
                                    })
                                : null,
                            icon: Icon(Icons.remove,
                                color: _canDescrease(guestsCount)
                                    ? Colors.black
                                    : Colors.grey)),
                        SizedBox(
                          width: 15,
                          child: TextFormField(
                            initialValue: guestsCount.toString(),
                            readOnly: true,
                            style: const TextStyle(color: Colors.black),
                            onSaved: (newValue) {
                              name = newValue!;
                            },
                            onChanged: (value) => setState(() {
                              guestsCount = int.parse(value);
                            }),
                          ),
                        ),
                        IconButton(
                          splashColor: const Color.fromARGB(160, 85, 85, 85),
                          onPressed: _canIncrease(
                                  guestsCount, widget.tableModel.guests)
                              ? () => setState(() {
                                    guestsCount = guestsCount++;
                                  })
                              : null,
                          icon: Icon(Icons.add,
                              color: _canIncrease(
                                      guestsCount, widget.tableModel.guests)
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Подтвердить'),
                onPressed: () {
                  final bloc = context.read<PlaceInfoBloc>();
                  bloc.add(AdminTableReserve(
                      placeId: placeId,
                      tableId: tableId,
                      guests: guestsCount,
                      start: widget.selectedDateTime,
                      end: DateTime.now().add(
                        const Duration(hours: 3),
                      ),
                      phoneNumber: phoneNumber,
                      name: name));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _removeReservation(int reservationId, int placeId, int tableNumber) {
    context.read<ReservationsBloc>().add(RemoveReservation(
        reservationId: reservationId,
        placeId: placeId,
        tableNumber: tableNumber));
  }

  bool _canIncrease(int reservedGuests, int maxGuests) =>
      reservedGuests < maxGuests;

  bool _canDescrease(int reservedGuests) => reservedGuests > 1;
}
