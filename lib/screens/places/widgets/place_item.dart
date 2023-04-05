import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../old_reservations/reservations_screen.dart';
import '../../tables/tables/tables_screen.dart';
import '../../update_place/update_place_screen.dart';

class PlaceItem extends StatelessWidget {
  final PlaceModel place;
  final void Function(PlaceModel place) onTap;

  const PlaceItem({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onTap(place),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    // width: 310.0,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: place.base64Logo != null
                            ? ImageService.imageFromBase64String(
                                    place.base64Logo!)
                                .image
                            : const AssetImage('assets/images/neft.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        // style: const TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'ID: ${place.id}',
                          // style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    place.description,
                    // style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Категория',
                        // style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => UpdatePlaceBloc()
                                ..add(UpdatePlaceLoad(id: place.id)),
                              child: const UpdatePlaceScreen(),
                            ),
                          ),
                        ),
                        child: const Text('Апдейт'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () => Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            TableReservationsBloc(place.tables)
                                              ..add(TableReservationsLoad(
                                                  placeId: place.id)),
                                        child: const ReservationsScreen(),
                                      ))),
                          child: const Text('Резервации')),
                      const SizedBox(width: 8),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
