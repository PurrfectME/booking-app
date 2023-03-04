// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReservationDialog extends StatefulWidget {
  int placeId;
  int tableId;
  int maxGuests;
  DateTime selectedDateTime;

  ReservationDialog({
    required this.placeId,
    required this.tableId,
    required this.maxGuests,
    required this.selectedDateTime,
  });

  @override
  State<ReservationDialog> createState() => _ReservationDIalogState();
}

class _ReservationDIalogState extends State<ReservationDialog> {
  String phoneNumber = '';
  String name = '';
  int guestsCount = 1;

  @override
  Widget build(BuildContext context) {
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
                initialValue: phoneNumber,
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
                initialValue: name,
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
                          ? () => guestsCount = guestsCount--
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
                        onChanged: (value) => guestsCount = int.parse(value)),
                  ),
                  IconButton(
                    splashColor: const Color.fromARGB(160, 85, 85, 85),
                    onPressed: _canIncrease(guestsCount, widget.maxGuests)
                        ? () => guestsCount = guestsCount++
                        : null,
                    icon: Icon(Icons.add,
                        color: _canIncrease(guestsCount, widget.maxGuests)
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
            context.read<PlaceInfoBloc>().add(AdminTableReserve(
                tableId: widget.tableId,
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
    ;
  }

  bool _canIncrease(int reservedGuests, int maxGuests) =>
      reservedGuests < maxGuests;

  bool _canDescrease(int reservedGuests) => reservedGuests > 1;
}
