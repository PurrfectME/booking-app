import 'package:booking_app/blocs/reservation_info/reservation_info_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/local/reservation_time.dart';
import '../../reserve_table/widgets/datetime_selector.dart';

class EditReservationScreen extends StatefulWidget {
  // final int placeId;
  final int reservationId;
  final ReservationInfoBloc riBloc;
  const EditReservationScreen(
      {super.key, required this.reservationId, required this.riBloc});

  @override
  State<EditReservationScreen> createState() => _EditReservationScreenState();
}

class _EditReservationScreenState extends State<EditReservationScreen> {
  late String phoneNumber;
  late String name;
  late int guestsCount;
  late DateTime start;
  late DateTime end;
  late String? comment;
  late bool excludeReshuffle;
  bool dateIsSet = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('РЕДАКТИРОВАНИЕ ЗАЯВКИ №${widget.reservationId}'),
        ),
        body: BlocConsumer<ReservationInfoBloc, ReservationInfoState>(
          bloc: widget.riBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ReservationInfoLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(radius: 20));
            } else if (state is ReservationInfoLoaded) {
              final reservation = state.data;

              phoneNumber = reservation.phoneNumber;
              name = reservation.name;
              guestsCount = reservation.guests;
              start = reservation.start;
              end = reservation.end;
              comment = reservation.comment;
              excludeReshuffle = reservation.excludeReshuffle;

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
                              child: Text('Дата и время бронирования')),
                          if (dateIsSet)
                            Text(
                              'C ${DateFormat('dd MMMM HH:mm', 'RU').format(start)} | До ${DateFormat('dd MMMM HH:mm', 'RU').format(end)}',
                            ),
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: name,
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
                            initialValue: '',
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Комментарий',
                                labelStyle: TextStyle(color: Colors.black)),
                            keyboardType: TextInputType.number,
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
                          onPressed: () => editReservation(
                              state.data.placeId, state.data.tableId),
                          child: const Text(
                            'Сохранить изменения',
                            style: TextStyle(color: Colors.white),
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

  void editReservation(int placeId, int tableId) {
    widget.riBloc.add(ReservationInfoEdit(
      reservationId: widget.reservationId,
      placeId: placeId,
      tableId: tableId,
      guests: guestsCount,
      start: start,
      end: end,
      phoneNumber: phoneNumber,
      name: name,
      excludeReshuffle: excludeReshuffle,
      comment: comment,
    ));

    Navigator.pop(context);
  }

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
}
