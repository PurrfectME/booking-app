import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  var currentGuestsCount = 1;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  void showTableReserveDialog(TableModel table) {
    final placeInfoBloc = context.read<PlaceInfoBloc>();

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReserveTableDialog(
            table: table,
            onReserveCallback: (guestsCount) {
              Navigator.pop(context);
              placeInfoBloc.add(PlaceTableReserve(
                  table.id,
                  guestsCount,
                  table.placeId,
                  selectedDateTime,
                  DateTime.now().add(const Duration(hours: 10))));
            });
      },
    );
  }

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
            return Stack(children: [
              Container(
                // width: 310.0,
                height: 350.0,
                foregroundDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.3),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 1,
                        image: AssetImage("assets/images/neft.jpg"),
                        fit: BoxFit.cover)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35, right: 20),
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
                ),
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  builder: (context, scrollController) => Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          controller: scrollController,
                          itemCount: state.data.length,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return state.data[index]?.table.id !=
                                    reservedTableId
                                ? TableCard(
                                    model: state.data[index]!,
                                    currentGuestsCount: currentGuestsCount,
                                    increaseCallback: _onGuestsCountIncrease,
                                    decreaseCallback: _onGuestsCountDecrease)
                                : const SizedBox();
                          },
                        ),
                      ))
            ]);
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

  void _onGuestsCountDecrease() {
    setState(() {
      currentGuestsCount--;
    });
  }

  void _onGuestsCountIncrease() {
    setState(() {
      currentGuestsCount++;
    });
  }

  _onDateTimeTap() async {
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
