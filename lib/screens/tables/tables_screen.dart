import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesScreen extends StatefulWidget {
  static const pageRoute = '/tables';
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  @override
  Widget build(BuildContext context) => BlocListener<TablesBloc, TablesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Выберите стол'),
          ),
          body: BlocBuilder<TablesBloc, TablesState>(
            builder: (context, state) {
              if (state is TablesLoading) {
                return const Center(
                    child: CupertinoActivityIndicator(radius: 20));
              } else if (state is TablesLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    children: state.data
                        .map(
                          (table) => InkWell(
                            onTap: () => _onTableUpdatePress(table),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              color: Colors.black,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    // width: 310.0,
                                    // height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      image: DecorationImage(
                                        opacity: 1,
                                        image: table.images.isNotEmpty
                                            ? table.images.last.image
                                            : const AssetImage(
                                                'assets/images/neft.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Стол: ${table.table.number}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      );

  void _onTableUpdatePress(TableViewModel table) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => UpdateTableBloc()..add(UpdateTableLoad(table)),
          child: const UpdateTableScreen(),
        ),
      ),
    );
  }
}
