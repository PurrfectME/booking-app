import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/screens/reserve_table/widgets/datetime_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReserveTableScreen extends StatefulWidget {
  final int tableNumber;
  const ReserveTableScreen({super.key, required this.tableNumber});

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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Забронировать стол №${widget.tableNumber}'),
        ),
        body: BlocConsumer<ReserveTableBloc, ReserveTableState>(
          listener: (context, state) {},
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
                          // if (!widget.isEdit)
                          //   Text(
                          //       'Дата: ${DateFormat('E, d MMM yyyy HH:mm', 'RU').format(widget.selectedDateTime)}',
                          //       style: const TextStyle(color: Colors.black))
                          // else
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //           'Начало: ${DateFormat('d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.start!))}'),
                          //       Text(
                          //           'Конец: ${DateFormat('d MMM yyyy HH:mm', 'RU').format(DateTime.fromMillisecondsSinceEpoch(widget.end!))}'),
                          //     ],
                          //   ),
                          OutlinedButton(
                              onPressed: () async => await _onDatePress(),
                              child: Text('Дата и время бронирования')),
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
                                    const BoxDecoration(color: Colors.red),
                                height: 65,
                                child: DropdownButton(
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

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     ElevatedButton(
                          //       style: ButtonStyle(
                          //         backgroundColor:
                          //             MaterialStateProperty.all(Colors.black),
                          //       ),
                          //       child: Text('Продлить'),
                          //       onPressed: () async => showMaterialModalBottomSheet(
                          //           expand: true,
                          //           context: context,
                          //           builder: (context) => ChangeTimeDialog(
                          //                 label: 'Продлить',
                          //               )),
                          //     ),
                          //     ElevatedButton(
                          //       style: ButtonStyle(
                          //         backgroundColor:
                          //             MaterialStateProperty.all(Colors.black),
                          //       ),
                          //       child: Text('Сдвинуть'),
                          //       onPressed: () => null,
                          //     )
                          //   ],
                          // )
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
                          onPressed: null,
                          child: const Text(
                            'Забронировать',
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

  Future _onDatePress() async {
    await showDialog<void>(
        context: context, builder: (context) => const DatetimeSelector());
  }
}
