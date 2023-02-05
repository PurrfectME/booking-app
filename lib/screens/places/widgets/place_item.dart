import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceItem extends StatelessWidget {
  final PlaceModel place;
  final void Function(PlaceModel place) onTap;

  const PlaceItem({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(place),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Container(
              margin: const EdgeInsets.all(7.0),
              // width: 310.0,
              height: 250.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      opacity: 1,
                      image: place.base64Logo != null
                          ? ImageService.imageFromBase64String(
                                  place.base64Logo!)
                              .image
                          : const AssetImage("assets/images/neft.jpg"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      color: Colors.grey[850], shape: BoxShape.circle),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "ID: ${place.id}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      place.description,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Категория",
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => UpdatePlaceBloc()
                                        ..add(UpdatePlaceLoad(id: place.id)),
                                      child: const UpdatePlaceScreen(),
                                    ))),
                        child: Text("Апдейт")),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
