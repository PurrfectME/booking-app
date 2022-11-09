import 'package:booking_app/models/table_model.dart';
import 'package:flutter/material.dart';

class PlaceInfo extends StatefulWidget {
  final List<TableModel> data;
  const PlaceInfo({super.key, required this.data});

  @override
  PlaceInfoState createState() {
    return PlaceInfoState();
  }
}

class PlaceInfoState extends State<PlaceInfo> {
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
            onTap: data[i].isFree
                ? () => showAlertDialog(context, data[i]).then((value) =>
                    value != null
                        ? setState((() => widget.data[i] = value))
                        : null)
                : null,
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

  Future<dynamic> showAlertDialog(BuildContext context, TableModel model) {
    Widget cancelButton = TextButton(
      child: const Text("Закрыть"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Подтвердить"),
      onPressed: () {
        model.isFree = false;
        model.guestsCount += 1;
        Navigator.pop(context, model);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Бронирование стола"),
      content: const Text("Укажите точное количество гостей и время брони"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Выбрать место")),
        body: Container(
          margin: const EdgeInsets.all(17.0),
          child: Stack(children: processTables(widget.data)),
        ));
  }
}
