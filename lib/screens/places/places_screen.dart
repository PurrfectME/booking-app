import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/place_box.dart';

class PlacesScreen extends StatefulWidget {
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
            return CupertinoActivityIndicator();
          } else if (state is PlacesError) {
            return Text(state.error);
          } else if (state is PlacesLoaded) {
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children:
                  state.data.map((place) => PlaceBox(data: place)).toList(),
            );
          } else {
            //если билдер не нашёл стейт в обработке ифов
            return SizedBox();
          }
        },
      ),
    );
  }
}
