import 'package:booking_app/places/place_box.dart';
import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  PlacesState createState() {
    return PlacesState();
  }
}

class PlacesState extends State<Places> {
  final _formKey = GlobalKey<FormState>();

  final data = [
    PlaceModel(name: "NEFT", currentGuests: 30, maxGuests: 100),
    PlaceModel(name: "FABRIQ", currentGuests: 6, maxGuests: 56),
    PlaceModel(name: "EMBER", currentGuests: 19, maxGuests: 76),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(title: const Text("Рестораны")),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: data.map((place) => PlaceBox(data: place)).toList(),
      ),
    );
  }
}

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
