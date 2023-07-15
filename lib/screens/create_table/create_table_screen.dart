// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTableScreen extends StatefulWidget {
  final TablesBloc tBloc;
  const CreateTableScreen({
    Key? key,
    required this.tBloc,
  }) : super(key: key);

  @override
  State<CreateTableScreen> createState() => _CreateTableScreenState();
}

class _CreateTableScreenState extends State<CreateTableScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<TablesBloc, TablesState>(
        bloc: widget.tBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CreateTableLoaded) {
            return Text('СОЗДАТЬ СТОЛ');
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
