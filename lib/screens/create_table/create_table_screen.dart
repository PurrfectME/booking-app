// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:booking_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  final _formKey = GlobalKey<FormState>();
  late FileImage image;
  late int number;
  late int guests;

  @override
  Widget build(BuildContext context) => BlocConsumer<TablesBloc, TablesState>(
        bloc: widget.tBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CreateTableLoaded) {
            return Scaffold(
                appBar: AppBar(title: Text('Создание стола')),
                body: Container(
                  margin: const EdgeInsets.only(top: 62),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          width: 200,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter number',
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  number = int.parse(value!);
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter guests',
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  guests = int.parse(value!);
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Here, you can handle your form submission.
                                  }
                                },
                                child: Text('Создать'),
                              )
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
}
