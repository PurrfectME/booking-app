import 'dart:io';
import 'dart:typed_data';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/services/image/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTableScreen extends StatefulWidget {
  const UpdateTableScreen({super.key});

  @override
  State<UpdateTableScreen> createState() => _UpdateTableScreenState();
}

class _UpdateTableScreenState extends State<UpdateTableScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<int> images = [1, 2, 3];
  List<XFile> _imageFiles = [];
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
              localObj = state.data;
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
                              onSaved: (value) {
                                final val = int.tryParse(value!);
                                localObj.table.number = val ?? 0;
                              },
                              onChanged: (value) {
                                final val = int.tryParse(value);
                                localObj.table.number = val ?? 0;
                              }
                              // The validator receives the text that the user has entered.
                              // validator: validatePhoneNumber),
                              ),
                          TextFormField(
                            initialValue: state.data.table.guests.toString(),
                            onSaved: (value) {
                              localObj.table.guests = int.tryParse(value!) ?? 0;
                            },
                            onChanged: (value) => localObj.table.guests =
                                int.tryParse(value) ?? 0,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: 'Количество гостей',
                                labelStyle: TextStyle(color: Colors.black)),
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
                            onPressed: () async => await ImageService()
                                .displayImagePickerBox(
                                    context, _onImageButtonPressed),
                            child: Text("Добавить фото",
                                style: TextStyle(color: Colors.white)),
                          )),
                          _imageFiles.isNotEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 169, 181, 178)),
                                  height: 280,
                                  child: GridView.count(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      crossAxisCount: images.length >= 3
                                          ? 3
                                          : images.length,
                                      primary: false,
                                      children: _previewImages()),
                                )
                              : const SizedBox()
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
                                  child: const Text("Сохранить"),
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
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFiles.isNotEmpty) {
      return _imageFiles
          .map((image) => Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        opacity: 1,
                        image: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                        ).image)),
              ))
          .toList();
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.grey,
          height: 300,
          child: Center(
              child: IconButton(
                  onPressed: () async => await ImageService()
                      .displayImagePickerBox(context, _onImageButtonPressed),
                  icon: const Icon(
                    Icons.photo_camera_back_outlined,
                    color: Colors.white,
                  ))),
        )
      ];
    }
  }

  Future _onImageButtonPressed(ImageSource source, BuildContext context) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      final resultFiles = <XFile>[];
      resultFiles.addAll(pickedFiles);
      resultFiles.addAll(_imageFiles);
      setState(() {
        _imageFiles = resultFiles;

        for (var file in resultFiles) {
          file.readAsBytes().then((value) => localObj.imagesBytes!.add(value));
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      Navigator.of(context).pop();
    }
  }
}
