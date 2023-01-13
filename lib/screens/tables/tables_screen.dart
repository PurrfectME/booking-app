import 'package:booking_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTablesScreen extends StatefulWidget {
  const UpdateTablesScreen({super.key});

  @override
  State<UpdateTablesScreen> createState() => _UpdateTablesScreenState();
}

class _UpdateTablesScreenState extends State<UpdateTablesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTablesBloc, UpdateTablesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Редактирование столов")),
        body: BlocBuilder<UpdateTablesBloc, UpdateTablesState>(
          builder: (context, state) {
            if (state is UpdateTablesLoaded) {
              return Container(
                child: Text("TABLES"),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
