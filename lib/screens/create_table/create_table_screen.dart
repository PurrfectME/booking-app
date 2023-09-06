// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateTableScreen extends StatefulWidget {
  final TablesBloc tBloc;
  final TableReservationsBloc trBloc;
  const CreateTableScreen({Key? key, required this.tBloc, required this.trBloc})
      : super(key: key);

  @override
  State<CreateTableScreen> createState() => _CreateTableScreenState();
}

class _CreateTableScreenState extends State<CreateTableScreen> {
  final _formKey = GlobalKey<FormState>();
  late FileImage image;
  late int number;
  late int guests;
  bool canBookOnline = false;

  @override
  Widget build(BuildContext context) => BlocConsumer<TablesBloc, TablesState>(
        bloc: widget.tBloc,
        listener: (context, state) {
          if (state is TableCreated) {
            widget.trBloc.add(TableReservationsLoad());
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CreateTableLoaded) {
            return Scaffold(
                appBar: AppBar(title: const Text('Создание стола')),
                body: Container(
                  margin: const EdgeInsets.only(top: 62),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Фото',
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              child: Container(
                                width: 378,
                                height: 320,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  image: DecorationImage(
                                      opacity: 1,
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage('assets/images/neft.jpg')),
                                ),
                              ),
                              onPressed: () async {
                                final pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  image = FileImage(File(pickedFile.path));
                                } else {
                                  print('No image selected.');
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 69),
                                width: 3,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 23, 23, 23),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Switch(
                                    inactiveTrackColor: Colors.grey,
                                    activeColor: Colors.white,
                                    activeTrackColor: Constants.mainPurple,
                                    value: canBookOnline,
                                    onChanged: (bool value) {
                                      setState(() {
                                        canBookOnline = !canBookOnline;
                                      });
                                    },
                                  ),
                                  const Text('Бронируется гостями онлайн',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const SizedBox(height: 60),
                              Row(
                                children: [
                                  const Text('Номер',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 66, 66, 66))),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 52,
                                    height: 52,
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Constants.mainPurple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 66, 66, 66),
                                              width: 2),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String? value) {
                                        number = int.parse(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  const Text('Количество мест',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 66, 66, 66))),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 52,
                                    height: 52,
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Constants.mainPurple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 66, 66, 66),
                                              width: 2),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String? value) {
                                        guests = int.parse(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: _createTable,
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    disabledForegroundColor:
                                        const Color.fromARGB(
                                            255, 155, 155, 155),
                                    backgroundColor: Constants.mainPurple,
                                    disabledBackgroundColor:
                                        const Color.fromARGB(255, 45, 45, 45),
                                    shape: const StadiumBorder()),
                                child: const SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: Center(
                                        child: Text('Создать',
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _createTable() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.tBloc.add(CreateTable(number: number, guests: guests));
      // Here, you can handle your form submission.
    }
  }
}
