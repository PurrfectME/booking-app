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
          decoration: BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
          child: const Text(
            'Свободно',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      : Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!DateTime.now().isAfter(start!))
                Text(
                    'Свободно до ${DateFormat('d HH:mm', 'RU').format(start!)}')
              else
                Text(
                  'Занят с ${DateFormat('d HH:mm', 'RU').format(start!)} до ${DateFormat('HH:mm', 'RU').format(end!)}',
                  style: TextStyle(fontSize: 13),
                ),
            ],
          ),
        );
}
