import 'dart:io';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartx/dartx.dart';

class UpdateTableScreen extends StatefulWidget {
  static const pageRoute = '/update-table';

  const UpdateTableScreen({super.key});

  @override
  State<UpdateTableScreen> createState() => _UpdateTableScreenState();
}

class _UpdateTableScreenState extends State<UpdateTableScreen> {
  final _formKey = GlobalKey<FormState>();
  dynamic _pickImageError;
  String? _retrieveDataError;

  late TableViewModel localObj;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Редактирование стола')),
        body: BlocConsumer<UpdateTableBloc, UpdateTableState>(
          listener: (context, state) {
            if (state is UpdateTableLoaded) {
              localObj = state.data.copyWith();
            } else if (state is UpdateTableSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Стол обновлён')),
              );

              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is UpdateTableLoaded) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                              initialValue: state.data.table.number.toString(),
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Номер стола',
                                  labelStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.text,
                              // onSaved: (value) {
                              //   final val = int.tryParse(value!);
                              //   localObj = localObj.copyWith(
                              //     table: localObj.table.copyWith(
                              //       number: val ?? 0
                              //     )
                              //   );
                              // },
                              onChanged: (value) {
                                final val = int.tryParse(value);
                                localObj = localObj.copyWith(
                                    table: localObj.table
                                        .copyWith(number: val ?? 0));
                              }
                              // The validator receives the text that the user has entered.
                              // validator: validatePhoneNumber),
                              ),
                          TextFormField(
                            initialValue: state.data.table.guests.toString(),
                            // onSaved: (value) {
                            //   localObj = localObj.copyWith(
                            //     table: localObj.table.copyWith(
                            //         guests: int.tryParse(value!) ?? 0),
                            //   );
                            // },
                            onChanged: (value) {
                              localObj = localObj.copyWith(
                                table: localObj.table
                                    .copyWith(guests: int.tryParse(value) ?? 0),
                              );
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Количество гостей',
                              labelStyle: TextStyle(color: Colors.black),
                            ),
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
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Депозит',
                                labelStyle: TextStyle(color: Colors.black)),
                            keyboardType: TextInputType.text,
                          ),
                          // Card(
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10)),
                          //   ),
                          //   color: const Color.fromARGB(255, 59, 59, 59),
                          //   child: GridView.count(
                          //       crossAxisCount: 3,
                          //       primary: false,
                          //       children: images),
                          // ),
                          Center(
                              child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: _onImageButtonPressed,
                            child: const Text('Добавить фото',
                                style: TextStyle(color: Colors.white)),
                          )),
                          if (localObj.imagesBytes.isNotEmpty)
                            Container(
                              // decoration: const BoxDecoration(
                              //     color: Color.fromARGB(255, 169, 181, 178)),
                              height: 280,
                              child: GridView.extent(
                                  maxCrossAxisExtent: 130,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  primary: false,
                                  children: _previewImages()),
                            ),
                        ],
                      ),
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  child: const Text('Сохранить'),
                                  onPressed: () => context
                                      .read<UpdateTableBloc>()
                                      .add(UpdateTable(localObj)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  List<Widget> _previewImages() {
    final retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return [retrieveError];
    }
    if (localObj.imagesBytes.isNotEmpty) {
      return localObj.imagesBytes
          .map<Widget>((image) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color.fromRGBO(180, 180, 180, 1))),
                child: Image.memory(
                  image,
                  fit: BoxFit.contain,
                ),
              ))
          .toList();
    } else if (_pickImageError != null) {
      return [
        Text(
          'Pick image error: $_pickImageError',
          textAlign: TextAlign.center,
        )
      ];
    } else {
      return [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.grey,
          height: 300,
          child: Center(
            child: IconButton(
              onPressed: _onImageButtonPressed,
              icon: const Icon(
                Icons.photo_camera_back_outlined,
                color: Colors.white,
              ),
            ),
          ),
        )
      ];
    }
  }

  Future _onImageButtonPressed() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      final filesBytes = <Uint8List>[];
      for (final file in pickedFiles) {
        filesBytes.add(await file.readAsBytes());
      }
      final updateImagesBytes = () {
        if (localObj.imagesBytes.isNotEmpty) {
          return List<Uint8List>.from(localObj.imagesBytes)..addAll(filesBytes);
        } else {
          return filesBytes;
        }
      }.call();
      localObj = localObj.copyWith(imagesBytes: updateImagesBytes);
      setState(() {});
      // Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      // Navigator.of(context).pop();
    }
  }
}
