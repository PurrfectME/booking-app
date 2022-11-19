import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class ReserveTableDialog extends StatefulWidget {
  final TableModel table;
  final Function(int guestsCount) onReserveCallback;
  const ReserveTableDialog(
      {super.key, required this.table, required this.onReserveCallback});

  @override
  State<ReserveTableDialog> createState() => _ReserveTableDialogState();
}

class _ReserveTableDialogState extends State<ReserveTableDialog> {
  var currentGuestsCount = 1;
  late DateTime selectedDateTime;
  var isDateSelected = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDateTime = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Бронирование стола"),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Количество гостей'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed:
                        currentGuestsCount > 1 ? _onGuestsCountDecrease : null,
                    icon: Icon(Icons.abc)),
                Text('$currentGuestsCount'),
                IconButton(
                    onPressed: _onGuestsCountIncrease, icon: Icon(Icons.abc))
              ],
            )
          ]),
      actions: [
        TextButton(
          child: const Text("Закрыть"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Подтвердить"),
          onPressed: () {
            widget.onReserveCallback(currentGuestsCount);
          },
        ),
      ],
    );
  }

  _onGuestsCountDecrease() {
    setState(() {
      currentGuestsCount--;
    });
  }

  _onGuestsCountIncrease() {
    setState(() {
      currentGuestsCount++;
    });
  }
}
