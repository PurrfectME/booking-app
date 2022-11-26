import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final PlaceModel place;
  final void Function(PlaceModel place) onTap;

  const PlaceItem({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(place),
      child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 1,
                  image: AssetImage("assets/images/neft.jpg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "ID: ${place.id}",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
