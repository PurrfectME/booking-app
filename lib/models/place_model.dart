import 'package:flutter/material.dart';

class PlaceModel extends Container {
  final String name;
  final int currentGuests;
  final int maxGuests;

  PlaceModel(
      {super.key,
      required this.name,
      required this.currentGuests,
      required this.maxGuests});
}
