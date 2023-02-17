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
  int currentGuestsCount = 1;
  late DateTime selectedDateTime;
  bool isDateSelected = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDateTime = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Center(child: Text('Бронирование стола')),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Количество гостей'),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: currentGuestsCount > 1
                          ? _onGuestsCountDecrease
                          : null,
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  Text('$currentGuestsCount'),
                  IconButton(
                      onPressed: _onGuestsCountIncrease,
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              )
            ]),
        actions: [
          TextButton(
            child: const Text('Закрыть'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Подтвердить'),
            onPressed: () {
              widget.onReserveCallback(currentGuestsCount);
            },
          ),
        ],
      );

  void _onGuestsCountDecrease() {
    setState(() {
      currentGuestsCount--;
    });
  }

  void _onGuestsCountIncrease() {
    setState(() {
      currentGuestsCount++;
    });
  }
}
