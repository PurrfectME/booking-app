import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/table_model.dart';
import 'package:booking_app/screens/place_info/widgets/reserve_table_dialog.dart';
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
  List<Widget> processTables(List<TableModel> data) {
    double top = 50;
    List<Positioned> result = <Positioned>[];

    if (data.isEmpty) {
      return <Widget>[];
    }

    for (var i = 0; i < data.length; i++) {
      if (i % 2 == 0) {
        data[i].config = TableConfig(left: 0, top: top);
      } else {
        data[i].config = TableConfig(right: 0, top: top);
        top += 250;
      }

      result.add(Positioned(
        left: data[i].config?.left,
        right: data[i].config?.right,
        top: data[i].config?.top,
        child: InkWell(
            onTap:
                data[i].isFree ? () => showTableReserveDialog(data[i]) : null,
            child: Container(
                width: 100,
                height: 100,
                color: data[i].isFree ? Colors.greenAccent : Colors.redAccent,
                child: Center(
                  child: Text(
                    data[i].isFree ? "Свободно" : "Занято",
                    textAlign: TextAlign.center,
                  ),
                ))),
      ));
    }

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
            onReserveCallback: (guestsCount, selectedDateTime) {
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
                return Container(
                  margin: const EdgeInsets.all(17.0),
                  child: Stack(children: processTables(state.data)),
                );
              } else {
                return SizedBox();
              }
            },
          )),
    );
  }
}
