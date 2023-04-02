import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourTimePicker extends StatelessWidget {
  final bool isHoursVisible;
  final void Function() onHoursTabPress;
  final void Function() onMinutesTabPress;
  final void Function(int hour) onHourTilePress;
  final void Function(int minute) onMinuteTilePress;
  final DateTime? start;
  final DateTime selectedTime;
  const HourTimePicker(
      {super.key,
      required this.onHoursTabPress,
      required this.onMinutesTabPress,
      required this.isHoursVisible,
      required this.onHourTilePress,
      required this.onMinuteTilePress,
      required this.start,
      required this.selectedTime});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              OutlinedButton(
                  onPressed: onHoursTabPress, child: const Text('ЧАСЫ')),
              OutlinedButton(
                  onPressed: !isHoursVisible || start != null
                      ? onMinutesTabPress
                      : null,
                  child: const Text('МИНУТЫ'))
            ],
          ),
          const SizedBox(),
          if (isHoursVisible) displayHours() else displayMinutes()
        ],
      );

  Widget displayMinutes() => GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        shrinkWrap: true,
        children: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
            .map((minute) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: start!.hour == selectedTime.hour &&
                                  minute >= selectedTime.minute ||
                              start!.hour > selectedTime.hour
                          ? Colors.white
                          : Colors.grey),
                  child: OutlinedButton(
                    style: const ButtonStyle(),
                    onPressed: () => selectedTime.minute <= minute ||
                            start!.hour > selectedTime.hour
                        ? onMinuteTilePress(minute)
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('mm', 'RU').format(DateTime(
                            selectedTime.year,
                            selectedTime.month,
                            selectedTime.day,
                            selectedTime.hour,
                            minute,
                          )),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Text('минут',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );

  Widget displayHours() => GridView.count(
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: 5,
        shrinkWrap: true,
        children: [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23
        ]
            .map((hour) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: selectedTime.hour <= hour
                        ? start?.hour == hour
                            ? Colors.greenAccent
                            : Colors.white
                        : const Color.fromARGB(255, 134, 134, 134),
                  ),
                  child: OutlinedButton(
                    style: const ButtonStyle(),
                    onPressed: () => selectedTime.hour <= hour
                        ? onHourTilePress(hour)
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('HH', 'RU').format(DateTime(
                            selectedTime.year,
                            selectedTime.month,
                            selectedTime.day,
                            hour,
                          )),
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                            hour == 1
                                ? 'час'
                                : hour == 2 || hour == 3 || hour == 4
                                    ? 'часа'
                                    : 'часов',
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );
}
