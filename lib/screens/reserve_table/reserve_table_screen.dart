import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/blocs/table_info/table_info_bloc.dart';
import 'package:booking_app/models/local/reservation_time.dart';
import 'package:booking_app/screens/reserve_table/widgets/datetime_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/table_reservations/table_reservations_bloc.dart';

class ReserveTableScreen extends StatefulWidget {
  final int tableNumber;
  final TableReservationsBloc tableReservationsBloc;
  final ReserveTableBloc reserveTableBloc;
  final TableInfoBloc tableInfoBloc;
  final DateTime? initialStart;
  final DateTime? initialEnd;
  const ReserveTableScreen({
    super.key,
    required this.tableNumber,
    required this.tableReservationsBloc,
    required this.reserveTableBloc,
    required this.tableInfoBloc,
    this.initialStart,
    this.initialEnd,
  });

  @override
  State<ReserveTableScreen> createState() => _ReserveTableScreenState();
}

class _ReserveTableScreenState extends State<ReserveTableScreen> {
  String phoneNumber = '';
  String name = '';
  int guestsCount = 1;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  String comment = '';
  bool excludeReshuffle = false;
  bool dateIsSet = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialStart != null) {
      dateIsSet = true;
      start = widget.initialStart!;
      end = widget.initialEnd!;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.initialStart != null
              ? 'Открыть стол №${widget.tableNumber}'
              : 'Забронировать стол №${widget.tableNumber}'),
        ),
        body: BlocConsumer<ReserveTableBloc, ReserveTableState>(
          bloc: widget.reserveTableBloc,
          listener: (context, state) {
            if (state is ReserveTableSuccess) {
              widget.tableInfoBloc.add(TableInfoLoad(
                  placeId: state.placeId, tableId: state.tableId));

              widget.tableReservationsBloc.add(TableReservationsLoad());

              if (widget.initialStart != null) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }
          },
          builder: (context, state) {
            if (state is ReserveTableLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is ReserveTableLoaded) {
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                              onPressed: () async => await _onDatePress(),
                              child: const Text('Дата и время бронирования')),
                          if (dateIsSet)
                            Text(
                              'C ${DateFormat('dd MMMM HH:mm', 'RU').format(start)} | До ${DateFormat('dd MMMM HH:mm', 'RU').format(end)}',
                            ),
                          TextFormField(
                            readOnly: widget.initialStart != null,
                            initialValue: widget.initialStart != null
                                ? 'Без телефона'
                                : '',
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: widget.initialStart != null,
                                  initialValue: widget.initialStart != null
                                      ? 'Без имени'
                                      : name,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      labelText: 'Имя',
                                      labelStyle:
                                          TextStyle(color: Colors.black)),
                                  keyboardType: TextInputType.text,
                                  onSaved: (newValue) {
                                    name = newValue!;
                                  },
                                  onChanged: (value) => name = value,
                                  // The validator receives the text that the user has entered.
                                  // validator: validatePhoneNumber),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
                                height: 65,
                                child: Row(
                                  children: [
                                    const Text('Гостей'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton(
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('1'),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('2'),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('3'),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('4'),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('5'),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('6'),
                                          value: 6,
                                        )
                                      ],
                                      onChanged: (value) => setState(() {
                                        guestsCount = value!;
                                      }),
                                      value: guestsCount,
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                          TextFormField(
                            initialValue: comment,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Комментарий',
                                labelStyle: TextStyle(color: Colors.black)),
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              comment = newValue!;
                            },
                            onChanged: (value) => comment = value,
                            // The validator receives the text that the user has entered.
                            // validator: validatePhoneNumber),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 18,
                                margin: const EdgeInsets.only(right: 10),
                                child: Checkbox(
                                    checkColor: Colors.white,
                                    value: excludeReshuffle,
                                    onChanged: (value) {
                                      setState(() {
                                        excludeReshuffle = value!;
                                      });
                                    }),
                              ),
                              const Text('Убрать из перетасовки?')
                            ],
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 60,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () =>
                              reserveTable(state.placeId, state.tableId),
                          child: Text(
                            widget.initialStart != null
                                ? 'Открыть до ${DateFormat('HH:mm', 'RU').format(widget.initialEnd!)}'
                                : 'Забронировать',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  Future _onDatePress() async {
    final result = await showDialog<ReservationTime>(
        context: context, builder: (context) => const DatetimeSelector());

    if (result != null) {
      setState(() {
        start = result.start;
        end = result.end;
        dateIsSet = true;
      });
    }
  }

  void reserveTable(int placeId, int tableId) {
    widget.reserveTableBloc.add(AdminReserveTable(
      placeId: placeId,
      tableId: tableId,
      guests: guestsCount,
      start: DateTime.now().add(Duration(minutes: 20)),
      end: DateTime.now().add(Duration(hours: 3)),
      phoneNumber: phoneNumber,
      name: name,
      excludeReshuffle: excludeReshuffle,
      comment: comment,
      inFact: widget.initialStart != null,
    ));
  }
}
