import 'package:booking_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTableScreen extends StatefulWidget {
  const UpdateTableScreen({super.key});

  @override
  State<UpdateTableScreen> createState() => _UpdateTableScreenState();
}

class _UpdateTableScreenState extends State<UpdateTableScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Image> images = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTableBloc, UpdateTableState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Редактирование стола")),
        body: BlocBuilder<UpdateTableBloc, UpdateTableState>(
          builder: (context, state) {
            if (state is UpdateTableLoaded) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue: state.data.number.toString(),
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelText: 'Номер стола',
                                  labelStyle: TextStyle(color: Colors.white)),
                              keyboardType: TextInputType.text,
                              onSaved: (newValue) {
                                // localObj.name = newValue!;
                              },
                              // onChanged: (value) => localObj.name = value,
                              // The validator receives the text that the user has entered.
                              // validator: validatePhoneNumber),
                            ),
                            TextFormField(
                              initialValue: state.data.guests.toString(),
                              onSaved: (newValue) {
                                // localObj.description = newValue!;
                              },
                              // onChanged: (value) =>
                              // localObj.description = value,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelText: 'Количество гостей',
                                  labelStyle: TextStyle(color: Colors.white)),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              // initialValue: state.data.,
                              onSaved: (newValue) {
                                // localObj.description = newValue!;
                              },
                              // onChanged: (value) =>
                              // localObj.description = value,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelText: 'Депозит',
                                  labelStyle: TextStyle(color: Colors.white)),
                              keyboardType: TextInputType.text,
                            ),
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              color: const Color.fromARGB(255, 59, 59, 59),
                              child: GridView.count(
                                  crossAxisCount: 3,
                                  primary: false,
                                  children: images),
                            ),
                            Center(
                                child: ElevatedButton(
                              onPressed: () => null,
                              child: Text("Добавить фото",
                                  style: TextStyle(color: Colors.white)),
                            )),
                          ],
                        ),
                        // Center(
                        //   child: Expanded(
                        //     child: ElevatedButton(
                        //       child: const Text("Сохранить"),
                        //       onPressed: () => context
                        //           .read<UpdatePlaceBloc>()
                        //           .add(UpdatePlace(localObj)),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
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
