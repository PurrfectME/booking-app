import 'package:flutter/material.dart';

import '../models/place_model.dart';
import '../models/table_model.dart';
import 'place_info.dart';

class PlaceBox extends StatelessWidget {
  final PlaceModel data;
  final mocked = [
    TableModel(isFree: true, guestsCount: 6, config: null),
    TableModel(isFree: false, guestsCount: 2, config: null),
    TableModel(isFree: false, guestsCount: 3, config: null),
    TableModel(isFree: true, guestsCount: 6, config: null)
  ];

  PlaceBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Future.delayed(Duration(seconds: 1)).then((value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlaceInfo(data: mocked))))
      },
      child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 1,
                  image: AssetImage("lib/images/neft.jpg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Места: ${data.currentGuests}/${data.maxGuests}",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
