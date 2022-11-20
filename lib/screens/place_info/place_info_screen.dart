import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/table_model.dart';
import 'package:booking_app/screens/place_info/widgets/reserve_table_dialog.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  PlaceInfoScreenState createState() {
    return PlaceInfoScreenState();
  }
}

class PlaceInfoScreenState extends State<PlaceInfoScreen> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  List<Widget> processTables(List<TableModel> data) {
    double top = 50;
    List<Positioned> result = <Positioned>[
      Positioned(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
                onPressed: _onDateTimeTap,
                child: Text(DateFormat('E, d MMM yyyy HH:mm', 'RU')
                    .format(selectedDateTime))),
          ),
        ],
      ))
    ];

    if (data.isEmpty) {
      return <Widget>[];
    }

    // for (var i = 0; i < data.length; i++) {
    //   if (i % 2 == 0) {
    //     data[i].config = TableConfig(left: 0, top: top);
    //   } else {
    //     data[i].config = TableConfig(right: 0, top: top);
    //     top += 250;
    //   }

    result.add(Positioned(
      // left: data[i].config?.left,
      // right: data[i].config?.right,
      // top: data[i].config?.top,
      child: TableInfo(),
      // child: InkWell(

      //     onTap:
      //         data[i].isFree ? () => showTableReserveDialog(data[i]) : null,
      //     child: Container(
      //         width: 100,
      //         height: 100,
      //         color: data[i].isFree ? Colors.greenAccent : Colors.redAccent,
      //         child: Center(
      //           child: Text(
      //             data[i].isFree ? "Свободно" : "Занято",
      //             textAlign: TextAlign.center,
      //           ),
      //         ))),
    ));
    // }

    return result;
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
              placeInfoBloc.add(
                  PlaceTableReserve(table.id, guestsCount, selectedDateTime));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceInfoBloc, PlaceInfoState>(
      listener: (context, state) {
        if (state is PlaceTableReserveSuccess) {
          // TODO: modal: success reserve
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Стол ${state.id} забронирован!')),
          );
          // Navigator.pop(context);
        }
        // else if (state is Place) {
        //   //TODO: error modal
        // }
      },
      child: Scaffold(
          appBar: AppBar(title: const Text("Выбрать место")),
          body: BlocBuilder<PlaceInfoBloc, PlaceInfoState>(
            builder: (context, state) {
              if (state is PlaceInfoLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: const CupertinoActivityIndicator(radius: 20)),
                  ],
                );
              } else if (state is PlaceInfoError) {
                return Text(state.error);
              } else if (state is PlaceInfoLoaded) {
                return GridView.count(
                    primary: false,
                    // padding: const EdgeInsets.all(20),
                    crossAxisCount: 1,
                    children: state.data
                        .map((table) => CarouselSlider.builder(
                            itemCount: state.data.length, //COUNT OF PHOTOS
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 50),
                                  child: TableInfo());
                            },
                            options: CarouselOptions(
                              aspectRatio: 1,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              onPageChanged: null,
                              scrollDirection: Axis.horizontal,
                            )))
                        .toList());
              } else {
                return SizedBox();
              }
            },
          )),
    );
  }

  _onDateTimeTap() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 20000)));

    if (date != null) {
      final time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }
}
