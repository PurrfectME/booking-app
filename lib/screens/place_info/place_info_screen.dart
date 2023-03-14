import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  PlaceInfoScreenState createState() => PlaceInfoScreenState();
}

class PlaceInfoScreenState extends State<PlaceInfoScreen> {
  late DateTime selectedDateTime;
  int? reservedTableId;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PlaceInfoBloc, PlaceInfoState>(
        listener: (context, state) {
          if (state is PlaceTableReserveSuccess) {
            reservedTableId = state.id;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Стол ${state.id} забронирован!')),
            );
          }
          // else if (state is Place) {
          //   //TODO: error modal
          // }
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            body: BlocBuilder<PlaceInfoBloc, PlaceInfoState>(
              builder: (context, state) {
                if (state is PlaceInfoLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(child: CupertinoActivityIndicator(radius: 20)),
                    ],
                  );
                } else if (state is PlaceInfoError) {
                  return Text(state.error);
                } else if (state is PlaceInfoLoaded) {
                  return CustomScrollView(
                    slivers: [
                      // TODO
                      // SliverAppBar(

                      // ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: FlexibleHeaderDelegate(
                          backgroundColor: Colors.transparent,
                          expandedHeight: 190,
                          statusBarHeight: MediaQuery.of(context).padding.top,
                          background: MutableBackground(
                            expandedWidget: Container(
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(.1),
                                        Colors.black.withOpacity(1),
                                      ]),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        opacity: 1,
                                        image: state.data.logo.image,
                                        fit: BoxFit.cover))),
                            collapsedColor: Colors.black,
                          ),
                          actions: [
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  _onDateTimeTap(state.data.placeId),
                            ),
                          ],
                          children: [
                            FlexibleTextItem(
                              text: state.data.placeName,
                              collapsedStyle: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: Colors.white),
                              collapsedAlignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18, bottom: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.data.placeName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 50,
                                      child: Card(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 59, 59, 59),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.white),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    '5.0',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  Text('200+'),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 59, 59, 59),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.yellow),
                                          ),
                                          onPressed: () => _onDateTimeTap(
                                              state.data.placeId),
                                          child: const Text(
                                            'Выбрать дату',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        DateFormat('E, d MMM yyyy HH:mm', 'RU')
                                            .format(selectedDateTime),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.data.tables.length,
                          (context, index) => Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.black),
                            child: !state.data.tables[index].isReservedByUser
                                ? TableCard(
                                    model: state.data.tables[index],
                                    selectedDateTime: selectedDateTime)
                                : const SizedBox(),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      );

  Future _onDateTimeTap(int placeId) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20000)));

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
      if (time != null) {
        setState(() {
          selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
        context.read<PlaceInfoBloc>().add(PlaceInfoLoad(
            DateTime(date.year, date.month, date.day, time.hour, time.minute)));
      }
    }
  }
}
