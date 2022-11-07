import 'package:flutter/material.dart';

class PlaceBox extends StatelessWidget {
  const PlaceBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.amber[600],
      width: 48.0,
      height: 48.0,
    );
  }
}
