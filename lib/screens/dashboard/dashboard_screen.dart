import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/dashboard/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  ElevatedButton(
                      onPressed: () {}, child: Text('Создать заведение'))
                ],
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 30),
                child: Row(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Заведения',
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        const SizedBox(height: 46),
                        SizedBox(
                          width: 596,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.places.length,
                              itemBuilder: (context, i) {
                                final place = state.places[i];
                                return PlaceItem(
                                  name: place.name,
                                  address: place.address,
                                  city: place.city,
                                  allowBooking: place.allowBooking,
                                );
                              },
                            ),
                          ),
                        )
                      ],
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
}
