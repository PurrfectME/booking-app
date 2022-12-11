import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class PlacesScreen extends StatefulWidget {
  static const pageRoute = '/places';
  const PlacesScreen({super.key});

  @override
  PlacesScreenState createState() {
    return PlacesScreenState();
  }
}

class PlacesScreenState extends State<PlacesScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(title: const Text("Рестораны")),
      body: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state is PlacesLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CupertinoActivityIndicator(radius: 20)),
              ],
            );
          } else if (state is PlacesError) {
            return Text(state.error);
          } else if (state is PlacesLoaded) {
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: state.data.isNotEmpty
                  ? state.data
                      .map((place) =>
                          PlaceItem(place: place, onTap: _onPlaceTap))
                      .toList()
                  : [],
            );
          } else {
            //если билдер не нашёл стейт в обработке ифов
            return SizedBox();
          }
        },
      ),
    );
  }

  void _onPlaceTap(PlaceModel place) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      PlaceInfoBloc(place: place)..add(PlaceInfoLoad(place.id)),
                  child: const PlaceInfoScreen(),
                )));
  }
}
