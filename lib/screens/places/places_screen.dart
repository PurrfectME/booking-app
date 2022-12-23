import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

  final filters = <Widget>[
    Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Card(
          color: const Color.fromARGB(255, 95, 95, 95),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: const [
                Text("ЗАГОЛОВОК"),
                SizedBox(height: 20),
                Text("описание"),
              ],
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Card(
          color: const Color.fromARGB(255, 95, 95, 95),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: const [
                Text("ЗАГОЛОВОК"),
                SizedBox(height: 20),
                Text("описание"),
              ],
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Card(
          color: const Color.fromARGB(255, 95, 95, 95),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: const [
                Text("ЗАГОЛОВОК"),
                SizedBox(height: 20),
                Text("описание"),
              ],
            ),
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: const Text("Рестораны"),
      ),
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
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 6, bottom: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () async => await showBarModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                              color: Colors.black,
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: filters.length,
                                        primary: true,
                                        itemBuilder: ((context, index) =>
                                            filters[index])),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: Card(
                                          color: const Color.fromARGB(
                                              255, 95, 95, 95),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Применить фильтры"),
                                            ),
                                          )),
                                    ),
                                  ])),
                        ),
                        child: const Icon(
                          Icons.tune_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.data.length,
                        primary: false,
                        itemBuilder: ((context, index) => PlaceItem(
                            place: state.data[index], onTap: _onPlaceTap))),
                  )
                ],
              ),
            );
          } else {
            //если билдер не нашёл стейт в обработке ифов
            return const SizedBox();
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
