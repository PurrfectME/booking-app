import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationLabel extends StatelessWidget {
  final bool hasReservationsToday;
  final DateTime? start;
  final DateTime? end;
  const ReservationLabel(
      {super.key,
      required this.hasReservationsToday,
      required this.start,
      required this.end});

  @override
  Widget build(BuildContext context) => !hasReservationsToday
      ? Container(
          width: 120,
          height: 26,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 23, 23, 23),
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Свободно',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        )
      : Container(
          width: 120,
          height: 26,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 23, 23, 23),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!DateTime.now().isAfter(start!))
                Text(
                    'Свободно до ${DateFormat('d HH:mm', 'RU').format(start!)}')
              else
                Text(
                  'Занят с ${DateFormat('d HH:mm', 'RU').format(start!)} до ${DateFormat('HH:mm', 'RU').format(end!)}',
                  style: const TextStyle(fontSize: 13),
                ),
            ],
          ),
        );
}
