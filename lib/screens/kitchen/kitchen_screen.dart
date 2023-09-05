import 'package:booking_app/blocs/kitchen/kitchen_bloc.dart';
import 'package:booking_app/models/local/kitchen_model.dart';
import 'package:booking_app/screens/kitchen/widgets/create_kitchen_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class KitchenScreen extends StatefulWidget {
  final KitchenBloc kBloc;
  const KitchenScreen({
    super.key,
    required this.kBloc,
  });

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<KitchenBloc, KitchenState>(
        bloc: widget.kBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is KitchenLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Кухня'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: () async => await _createKitchenItem(),
                      child: const Text('Создать позицию')),
                ],
              ),
              body: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 40,
                  columns: const [
                    DataColumn(
                        label: Text('Название',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Количество',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Дата',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Юзер',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  ],
                  rows: state.kitchenData
                      .map((x) => DataRow(cells: [
                            DataCell(Text(x.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                            DataCell(Text(x.amount.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                            DataCell(Text(
                                DateFormat('d/M/y HH:mm', 'RU').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        x.date)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                            DataCell(Text(x.user,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                          ]))
                      .toList(),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future _createKitchenItem() async {
    final data = await showDialog<KitchenModel>(
        context: context,
        builder: (context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Создать продукт кухни',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(width: 500, child: CreateKitchenItemForm()),
            ));

    if (data == null) {
      return;
    }

    widget.kBloc.add(CreateKitchenItem(kitchen: data));
  }
}
