import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/dashboard/widgets/place_item.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/create_place_form.dart';

class DashboardScreen extends StatefulWidget {
  static const pageRoute = '/dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DashboardLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('UReserve'),
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 65),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder()),
                        onPressed: () => _createPlace(state.user.id!),
                        child: const Text('Создать заведение')),
                  )
                ],
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.user.email,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    backgroundColor: Colors.black,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 2))),
                                onPressed: () {},
                                child: const SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: Center(
                                        child: Text('Выйти',
                                            style: TextStyle(fontSize: 20)))))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 140),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 69),
                            width: 3,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 23, 23, 23),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 42),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Заведения',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                          const SizedBox(height: 46),
                          if (state.places.isEmpty)
                            const Text(
                              'Нет заведений',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 22),
                            )
                          else
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                                shrinkWrap: true,
                                itemCount: state.places.length,
                                itemBuilder: (context, i) {
                                  final place = state.places[i];
                                  return UnconstrainedBox(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                                builder: (context) =>
                                                    MultiBlocProvider(
                                                        providers: [
                                                          BlocProvider(
                                                              create: (context) =>
                                                                  TablesBloc(
                                                                      placeId: place
                                                                          .id)),
                                                          BlocProvider(
                                                              create: (context) =>
                                                                  TableReservationsBloc(
                                                                      place
                                                                          .tables)
                                                                    ..add(TableReservationsLoad(
                                                                        placeId:
                                                                            place.id))),
                                                        ],
                                                        child:
                                                            const TablesScreen())));
                                      },
                                      child: PlaceItem(
                                        id: place.id,
                                        name: place.name,
                                        address: place.address,
                                        city: place.city,
                                        allowBooking: place.allowBooking,
                                        onwerId: place.ownerId,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future _createPlace(int ownerId) async {
    final data = await showDialog<CreatePlaceModel>(
        context: context,
        builder: (context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Создать заведение',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content:
                  SizedBox(height: 350, width: 500, child: CreatePlaceForm()),
            ));

    if (data == null) {
      return;
    }

    context.read<DashboardBloc>().add(CreatePlace(
        ownerId: ownerId,
        name: data.name,
        city: data.city,
        address: data.address));
  }
}
