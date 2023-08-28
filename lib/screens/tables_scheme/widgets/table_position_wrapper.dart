import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class TablePositionWrapper {
  final TablePosition position;
  final UniqueKey key;
  TablePositionWrapper({
    required this.position,
    required this.key,
  });

  static List<TablePositionWrapper> wrap(List<TablePosition> items) => items
      .map((e) => TablePositionWrapper(key: UniqueKey(), position: e))
      .toList();
}
