import 'package:booking_app/models/local/reservation_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeSelector extends StatefulWidget {
  const DatetimeSelector({super.key});

  @override
  State<DatetimeSelector> createState() => _DatetimeSelectorState();
}

class _DatetimeSelectorState extends State<DatetimeSelector> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  bool startTimeIsSet = false;

  int? startHour;
  int? startMinute;

  int? endHour;
  int? endMinute;

  bool isHoursVisible = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ДАТА И ВРЕМЯ'),
          actions: [
            const IconButton(onPressed: null, icon: Icon(Icons.calendar_month))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 75,
                    width: 120,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(8),
                    color: !startTimeIsSet ? Colors.redAccent : Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text('C')],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(DateFormat('d MMMM', 'RU').format(start)),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2))),
                                    child: Text(
                                      startHour == null
                                          ? ''
                                          : DateFormat('HH', 'RU').format(
                                              DateTime(start.year, start.month,
                                                  start.day, startHour!)),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const Text(':'),
                                  Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2))),
                                    child: Text(
                                        startMinute == null
                                            ? ''
                                            : DateFormat('mm', 'RU').format(
                                                DateTime(
                                                    start.year,
                                                    start.month,
                                                    start.day,
                                                    startHour!,
                                                    startMinute!)),
                                        style: const TextStyle(fontSize: 14)),
                                  )
                                ],
                              )
                            ]),
                        const SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 120,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(8),
                    color: endHour == null || endMinute == null
                        ? Colors.redAccent
                        : Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text('До')],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(DateFormat('d MMMM', 'RU').format(end)),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2))),
                                    child: Text(
                                      endHour == null
                                          ? ''
                                          : DateFormat('mm', 'RU').format(
                                              DateTime(end.year, end.month,
                                                  end.day, endHour!)),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const Text(':'),
                                  Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2))),
                                    child: Text(
                                        endMinute == null
                                            ? ''
                                            : DateFormat('mm', 'RU').format(
                                                DateTime(
                                                    end.year,
                                                    end.month,
                                                    end.day,
                                                    endHour!,
                                                    endMinute!)),
                                        style: const TextStyle(fontSize: 14)),
                                  )
                                ],
                              )
                            ]),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              if (startTimeIsSet)
                const Text(
                  'Во сколько придёт гость?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              else
                const Text(
                  'До скольки будет гость?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: onHoursTabPress, child: Text('ЧАСЫ')),
                  OutlinedButton(
                      onPressed: startHour == null ? null : onTimeTabPress,
                      child: Text('МИНУТЫ'))
                ],
              ),
              const SizedBox(),
              if (isHoursVisible) displayHours() else displayMinutes()
            ],
          ),
        ),
      );

  void onHoursTabPress() {
    setState(() {
      isHoursVisible = true;
    });
  }

  void onTimeTabPress() {
    setState(() {
      isHoursVisible = false;
    });
  }

  void onHourTilePress(int hour) {
    if (!startTimeIsSet) {
      setState(() {
        startHour = hour;
        isHoursVisible = false;
      });
    } else {
      setState(() {
        endHour = hour;
        isHoursVisible = false;
      });
    }
  }

  void onMinuteTilePress(int minute) {
    if (!startTimeIsSet) {
      setState(() {
        startMinute = minute;
        isHoursVisible = true;
        startTimeIsSet = true;
      });
    } else {
      setState(() {
        endMinute = minute;
        isHoursVisible = true;
        // startTimeIsSet = true;
      });
      Navigator.pop(
          context,
          ReservationTime(
              start: DateTime(
                  start.year, start.month, start.day, startHour!, startMinute!),
              end: DateTime(
                  end.year, end.month, end.day, endHour!, endMinute!)));
    }
  }

  Widget displayMinutes() => GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: OutlinedButton(
              onPressed: () => onMinuteTilePress(00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('00'),
                  Text('минут'),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: OutlinedButton(
              onPressed: () => onMinuteTilePress(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('05'),
                  Text('минут'),
                ],
              ),
            ),
          ),
        ],
      );

  Widget displayHours() => GridView.count(
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 5,
          shrinkWrap: true,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: OutlinedButton(
                onPressed: () => onHourTilePress(00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('00'),
                    Text('часов'),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: OutlinedButton(
                onPressed: () => onHourTilePress(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('01'),
                    Text('час'),
                  ],
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('02'),
            //       Text('часа'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('03'),
            //       Text('часа'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('04'),
            //       Text('часа'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('05'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('06'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('07'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('08'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('09'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('10'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('11'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('12'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('13'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('14'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('15'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('16'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('17'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('18'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('19'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('20'),
            //       Text('часов'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('21'),
            //       Text('час'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('22'),
            //       Text('часа'),
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black, width: 2)),
            //   child: Column(
            //     children: const [
            //       Text('23'),
            //       Text('часа'),
            //     ],
            //   ),
            // ),
          ]);
}
