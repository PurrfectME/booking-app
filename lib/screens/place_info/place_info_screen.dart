import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  PlaceInfoScreenState createState() {
    return PlaceInfoScreenState();
  }
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

  // void showTableReserveDialog(TableModel table) {
  //   final placeInfoBloc = context.read<PlaceInfoBloc>();

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ReserveTableDialog(
  //           table: table,
  //           onReserveCallback: (guestsCount) {
  //             Navigator.pop(context);
  //             placeInfoBloc.add(PlaceTableReserve(
  //                 table.id,
  //                 guestsCount,
  //                 table.placeId,
  //                 selectedDateTime,
  //                 DateTime.now().add(const Duration(hours: 10))));
  //           });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceInfoBloc, PlaceInfoState>(
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
          // appBar: AppBar(title: const Text("Выбрать место")),
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
                SliverPersistentHeader(
                  pinned: true,
                  delegate: FlexibleHeaderDelegate(
                    expandedHeight: 190,
                    statusBarHeight: MediaQuery.of(context).padding.top,
                    background: MutableBackground(
                      expandedWidget: Stack(children: [
                        Container(
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(.1),
                                Colors.black.withOpacity(1),
                              ],
                            ),
                          ),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  opacity: 1,
                                  image: AssetImage("assets/images/neft.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ]),
                      collapsedColor: Colors.black,
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                    children: [
                      FlexibleTextItem(
                        text: state.data[0]!.placeName,
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.data[0]!.placeName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 50,
                              child: Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  color: const Color.fromARGB(255, 59, 59, 59),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.white),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "5.0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          const Text("200+"),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              height: 50,
                              child: Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  color: const Color.fromARGB(255, 59, 59, 59),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow)),
                                    child: const Text(
                                      "Выбрать дату",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: _onDateTimeTap,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: state.data.length, (context, index) {
                  return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black),
                      child: !state.data[index]!.isReservedByUser
                          ? TableCard(
                              model: state.data[index]!,
                              selectedDateTime: selectedDateTime)
                          : const SizedBox());
                }))
              ],
            );
            // return TableWrapper(
            //     onDateTimeTap: _onDateTimeTap,
            //     selectedDateTime: selectedDateTime,
            //     data: state.data,
            //     showTableReserveDialog: showTableReserveDialog,
            //     reservedTableId: reservedTableId);
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

  void _onDateTimeTap() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20000)));

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (time != null) {
        setState(() {
          selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }
}
