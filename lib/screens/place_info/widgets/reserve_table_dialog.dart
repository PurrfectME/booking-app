import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReserveTableDialog extends StatefulWidget {
  final TableModel table;
  final Function(int guestsCount, DateTime dateTime) onReserveCallback;
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
            ),
            Text('Укажите время'),
            TextButton(
                onPressed: _onDateTimeTap,
                child: Text(DateFormat(
                        isDateSelected
                            ? 'E, d MMM yyyy HH:mm'
                            : 'E, d MMM yyyy',
                        'RU')
                    .format(selectedDateTime)))
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
            widget.onReserveCallback(currentGuestsCount, selectedDateTime);
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

  _onDateTimeTap() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 20000)));

    if (date != null) {
      final time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          isDateSelected = true;
          selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }
}
