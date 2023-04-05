import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'widgets/widgets.dart';

class PlacesScreen extends StatefulWidget {
  static const pageRoute = '/places';
  const PlacesScreen({super.key});

  @override
  PlacesScreenState createState() => PlacesScreenState();
}

class PlacesScreenState extends State<PlacesScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: Colors.black,
        key: _formKey,
        appBar: AppBar(
          title: const Text('Рестораны'),
          actions: [
            IconButton(
              onPressed: _onFiltersTap,
              icon: const Icon(
                Icons.tune_outlined,
                color: Colors.black,
              ),
            ),
          ],
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
              return Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        newAppPress(
                            state.data.first.tables, state.data.first.id);
                      },
                      child: const Text('NEW APP')),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) => PlaceItem(
                      place: state.data[index],
                      onTap: _onPlaceTap,
                    ),
                    separatorBuilder: (context, _) =>
                        const SizedBox(height: 16),
                  ),
                ],
              );
            } else {
              //если билдер не нашёл стейт в обработке ифов
              return const SizedBox();
            }
          },
        ),
      );

  Widget filterItem() => Container(
        width: double.infinity,
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: const [
            SizedBox(height: 20),
            Text('ЗАГОЛОВОК'),
            SizedBox(height: 20),
            Text('описание'),
          ],
        ),
      );

  void newAppPress(List<TableModel> tables, int placeId) {
    Navigator.push<void>(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => ReservationsBloc(),
                    ),
                    BlocProvider(
                      create: (context) => TableInfoBloc(),
                    ),
                    // BlocProvider(
                    //   create: (context) => ReserveTab(),
                    // ),
                    // BlocProvider(
                    //   create: (context) => ReservationInfoBloc(),
                    // ),
                    BlocProvider(
                      create: (context) => TableReservationsBloc(tables)
                        ..add(TableReservationsLoad(placeId: placeId)),
                    ),
                  ],
                  child: const TablesScreen(),
                )));
  }

  void _onFiltersTap() {
    showBarModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              // physics:
              //     const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => filterItem(),
            ),
          ),
          SizedBox(
            //TODO: make expanded
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Применить фильтры'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlaceTap(PlaceModel place) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              PlaceInfoBloc(id: place.id)..add(PlaceInfoLoad(DateTime.now())),
          child: const PlaceInfoScreen(),
        ),
      ),
    );
  }
}
