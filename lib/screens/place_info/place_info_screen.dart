import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/place_info/widgets/widgets.dart';
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
          appBar: AppBar(title: const Text("Выбрать место")),
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
                return TableWrapper(
                    onDateTimeTap: _onDateTimeTap,
                    selectedDateTime: selectedDateTime,
                    data: state.data,
                    showTableReserveDialog: showTableReserveDialog,
                    reservedTableId: reservedTableId);
              } else {
                return const SizedBox();
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
