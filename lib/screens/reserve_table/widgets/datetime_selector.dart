import 'package:booking_app/models/local/reservation_time.dart';
import 'package:booking_app/screens/reserve_table/widgets/hour_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeSelector extends StatefulWidget {
  const DatetimeSelector({super.key});

  @override
  State<DatetimeSelector> createState() => _DatetimeSelectorState();
}

class _DatetimeSelectorState extends State<DatetimeSelector> {
  DateTime selectedTime = DateTime.now();

  DateTime? start;
  DateTime? end;

  bool startTimeIsSet = false;
  bool isHoursVisible = true;

  bool isFromVisible = true;
  bool isToVisible = false;

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
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                            isFromVisible ? Colors.greenAccent : Colors.white),
                    onPressed: () => setState(() {
                      isFromVisible = true;
                      isToVisible = false;
                    }),
                    child: Container(
                      height: 75,
                      width: 120,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(8),
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
                                Text(start == null
                                    ? DateFormat('d MMMM', 'RU')
                                        .format(selectedTime)
                                    : DateFormat('d MMMM', 'RU')
                                        .format(start!)),
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
                                        start == null
                                            ? ''
                                            : DateFormat('HH', 'RU').format(
                                                DateTime(
                                                    start!.year,
                                                    start!.month,
                                                    start!.day,
                                                    start!.hour)),
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
                                          start == null
                                              ? ''
                                              : DateFormat('mm', 'RU').format(
                                                  DateTime(
                                                      start!.year,
                                                      start!.month,
                                                      start!.day,
                                                      start!.hour,
                                                      start!.minute)),
                                          style: const TextStyle(fontSize: 14)),
                                    )
                                  ],
                                )
                              ]),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                            !isFromVisible ? Colors.greenAccent : Colors.white),
                    onPressed: !startTimeIsSet
                        ? null
                        : () => setState(() {
                              isFromVisible = false;
                              isToVisible = true;
                            }),
                    child: Container(
                      height: 75,
                      width: 120,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(8),
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
                                Text(end == null
                                    ? DateFormat('d MMMM', 'RU')
                                        .format(selectedTime)
                                    : DateFormat('d MMMM', 'RU').format(end!)),
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
                                        end == null
                                            ? ''
                                            : DateFormat('HH', 'RU').format(
                                                DateTime(end!.year, end!.month,
                                                    end!.day, end!.hour)),
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
                                          end == null
                                              ? ''
                                              : DateFormat('mm', 'RU').format(
                                                  DateTime(
                                                      end!.year,
                                                      end!.month,
                                                      end!.day,
                                                      end!.hour,
                                                      end!.minute)),
                                          style: const TextStyle(fontSize: 14)),
                                    )
                                  ],
                                )
                              ]),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isFromVisible)
                const Text(
                  'Во сколько придёт гость?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              else
                const Text(
                  'До скольки будет гость?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              if (isFromVisible)
                HourTimePicker(
                  isHoursVisible: isHoursVisible,
                  onHoursTabPress: onHoursTabPress,
                  onMinutesTabPress: onMinutesTabPress,
                  onHourTilePress: onHourTilePress,
                  onMinuteTilePress: onMinuteTilePress,
                  start: start,
                  selectedTime: selectedTime,
                )
              else
                HourTimePicker(
                  isHoursVisible: isHoursVisible,
                  onHoursTabPress: onHoursTabPress,
                  onMinutesTabPress: onMinutesTabPress,
                  onHourTilePress: onHourTilePress,
                  onMinuteTilePress: onMinuteTilePress,
                  start: start,
                  selectedTime: selectedTime,
                )
            ],
          ),
        ),
      );

  void onHoursTabPress() {
    setState(() {
      isHoursVisible = true;
    });
  }

  void onMinutesTabPress() {
    setState(() {
      isHoursVisible = false;
    });
  }

  void onHourTilePress(int hour) {
    if (!startTimeIsSet) {
      setState(() {
        start = DateTime(
            selectedTime.year, selectedTime.month, selectedTime.day, hour);
        isHoursVisible = false;
      });
    } else {
      setState(() {
        end = DateTime(
            selectedTime.year, selectedTime.month, selectedTime.day, hour);
        isHoursVisible = false;
      });
    }
  }

  void onMinuteTilePress(int minute) {
    if (!startTimeIsSet) {
      setState(() {
        start = DateTime(
            start!.year, start!.month, start!.day, start!.hour, minute);
        isHoursVisible = true;
        startTimeIsSet = true;
        isFromVisible = false;
      });
    } else {
      setState(() {
        end = DateTime(end!.year, end!.month, end!.day, end!.hour, minute);
        isHoursVisible = true;
        // startTimeIsSet = true;
      });

      Navigator.pop(
          context,
          ReservationTime(
              start: DateTime(start!.year, start!.month, start!.day,
                  start!.hour, start!.minute),
              end: DateTime(
                  end!.year, end!.month, end!.day, end!.hour, end!.minute)));
    }
  }

  //TODO: создать ивент который каждую минуту(5 имнут) обновляет стейт

  // Widget displayMinutes() => GridView.count(
  //       crossAxisCount: 4,
  //       mainAxisSpacing: 3,
  //       crossAxisSpacing: 3,
  //       shrinkWrap: true,
  //       children: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
  //           .map((minute) => Container(
  //                 decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.black, width: 2),
  //                     color: start!.hour >= selectedTime.hour &&
  //                             minute >= selectedTime.minute
  //                         ? Colors.white
  //                         : Colors.grey),
  //                 child: OutlinedButton(
  //                   style: const ButtonStyle(),
  //                   onPressed: () => selectedTime.minute <= minute
  //                       ? onMinuteTilePress(minute)
  //                       : null,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         DateFormat('mm', 'RU').format(DateTime(
  //                           selectedTime.year,
  //                           selectedTime.month,
  //                           selectedTime.day,
  //                           selectedTime.hour,
  //                           minute,
  //                         )),
  //                         style: const TextStyle(color: Colors.black),
  //                       ),
  //                       const Text('минут',
  //                           style: TextStyle(color: Colors.black)),
  //                     ],
  //                   ),
  //                 ),
  //               ))
  //           .toList(),
  //     );

  // Widget displayHours() => GridView.count(
  //       mainAxisSpacing: 3,
  //       crossAxisSpacing: 3,
  //       crossAxisCount: 5,
  //       shrinkWrap: true,
  //       children: [
  //         0,
  //         1,
  //         2,
  //         3,
  //         4,
  //         5,
  //         6,
  //         7,
  //         8,
  //         9,
  //         10,
  //         11,
  //         12,
  //         13,
  //         14,
  //         15,
  //         16,
  //         17,
  //         18,
  //         19,
  //         20,
  //         21,
  //         22,
  //         23
  //       ]
  //           .map((hour) => Container(
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.black, width: 2),
  //                   color: selectedTime.hour <= hour
  //                       ? start?.hour == hour
  //                           ? Colors.greenAccent
  //                           : Colors.white
  //                       : const Color.fromARGB(255, 134, 134, 134),
  //                 ),
  //                 child: OutlinedButton(
  //                   style: const ButtonStyle(),
  //                   onPressed: () => selectedTime.hour <= hour
  //                       ? onHourTilePress(hour)
  //                       : null,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         DateFormat('HH', 'RU').format(DateTime(
  //                           selectedTime.year,
  //                           selectedTime.month,
  //                           selectedTime.day,
  //                           hour,
  //                         )),
  //                         style: const TextStyle(color: Colors.black),
  //                       ),
  //                       Text(
  //                           hour == 1
  //                               ? 'час'
  //                               : hour == 2 || hour == 3 || hour == 4
  //                                   ? 'часа'
  //                                   : 'часов',
  //                           style: const TextStyle(color: Colors.black)),
  //                     ],
  //                   ),
  //                 ),
  //               ))
  //           .toList(),
  //     );
}
