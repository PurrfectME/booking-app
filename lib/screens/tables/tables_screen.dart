import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/db/table_model.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите стол'),
      ),
      body: BlocBuilder<TablesBloc, TablesState>(
        builder: (context, state) {
          if (state is TablesLoading) {
            return const Center(child: CupertinoActivityIndicator(radius: 20));
          } else if (state is TablesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                children: state.data
                    .map((table) => InkWell(
                          onTap: () => _onTableUpdatePress(table),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            color: const Color.fromARGB(255, 59, 59, 59),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.all(7.0),
                                // width: 310.0,
                                height: 150.0,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        opacity: 1,
                                        image: AssetImage(
                                            "assets/images/neft.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Text('Стол: ${table.number}')
                            ]),
                          ),
                        ))
                    .toList(),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  _onTableUpdatePress(TableModel table) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      UpdateTableBloc()..add(UpdateTableLoad(table)),
                  child: const UpdateTableScreen(),
                )));
  }
}
