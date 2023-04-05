// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/old_reservations/widgets/change_time_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ReservationDialog extends StatefulWidget {
  final TableReservationsBloc reservationsBloc;
  int placeId;
  int tableId;
  int maxGuests;
  DateTime selectedDateTime;
  String phoneNumber;
  String name;
  int guestsCount;
  bool isEdit;
  int? reservationId;
  int? start;
  int? end;

  ReservationDialog({
    required this.reservationsBloc,
    required this.placeId,
    required this.tableId,
    required this.maxGuests,
    required this.selectedDateTime,
    required this.phoneNumber,
    required this.name,
    required this.guestsCount,
    required this.isEdit,
    this.reservationId,
    this.start,
    this.end,
  });

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(
          'Данные брони',
          style: TextStyle(color: Colors.black),
        ),
        content: SizedBox(
          height: 260,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isEdit)
                  Text(
                      'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(widget.selectedDateTime)}',
                      style: const TextStyle(color: Colors.black))
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Начало: ${DateFormat('d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.start!))}'),
                      Text(
                          'Конец: ${DateFormat('d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.end!))}'),
                    ],
                  ),
                TextFormField(
                  initialValue: widget.phoneNumber,
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
                    widget.phoneNumber = newValue!;
                  },
                  onChanged: (value) => widget.phoneNumber = value,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                TextFormField(
                  initialValue: widget.name,
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
                    widget.name = newValue!;
                  },
                  onChanged: (value) => widget.name = value,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                Row(
                  children: [
                    const Text('Гостей'),
                    IconButton(
                        splashColor: const Color.fromARGB(160, 85, 85, 85),
                        onPressed: _canDescrease(widget.guestsCount)
                            ? () {
                                setState(() {
                                  widget.guestsCount--;
                                });
                              }
                            : null,
                        icon: Icon(Icons.remove,
                            color: _canDescrease(widget.guestsCount)
                                ? Colors.black
                                : Colors.grey)),
                    SizedBox(
                      width: 15,
                      child: Text(widget.guestsCount.toString()),
                    ),
                    IconButton(
                      splashColor: const Color.fromARGB(160, 85, 85, 85),
                      onPressed:
                          _canIncrease(widget.guestsCount, widget.maxGuests)
                              ? () {
                                  setState(() {
                                    widget.guestsCount++;
                                  });
                                }
                              : null,
                      icon: Icon(Icons.add,
                          color:
                              _canIncrease(widget.guestsCount, widget.maxGuests)
                                  ? Colors.black
                                  : Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: Text('Продлить'),
                      onPressed: () async => showMaterialModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (context) => ChangeTimeDialog(
                                label: 'Продлить',
                              )),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: Text('Сдвинуть'),
                      onPressed: () => null,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            child: const Text(
              'Отмена',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            child: const Text('Подтвердить',
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (!widget.isEdit) {
                widget.reservationsBloc.add(AdminTableReserve(
                    placeId: widget.placeId,
                    tableId: widget.tableId,
                    guests: widget.guestsCount,
                    start: widget.selectedDateTime,
                    end: widget.selectedDateTime.add(
                      const Duration(hours: 3),
                    ),
                    phoneNumber: widget.phoneNumber,
                    name: widget.name));
              } else {
                widget.reservationsBloc.add(AdminEditReservation(
                    reservationId: widget.reservationId!,
                    placeId: widget.placeId,
                    tableId: widget.tableId,
                    guests: widget.guestsCount,
                    start: widget.selectedDateTime,
                    end: DateTime.now().add(
                      const Duration(hours: 3),
                    ),
                    phoneNumber: widget.phoneNumber,
                    name: widget.name,
                    comment: 'event.'));
              }

              Navigator.of(context).pop();
            },
          ),
        ],
      );

  bool _canIncrease(int reservedGuests, int maxGuests) =>
      reservedGuests < maxGuests;

  bool _canDescrease(int reservedGuests) => reservedGuests > 1;
}
