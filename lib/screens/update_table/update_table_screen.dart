import 'dart:io';
import 'dart:ui';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/db/table_model.dart';
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
  bool _isBlurredImageVisible = false;

  late TableModel localObj;

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
                              onPressed: () => _displayPickImageDialog(context),
                              child: Text("Добавить фото",
                                  style: TextStyle(color: Colors.white)),
                            )),
                            _imageFiles.isNotEmpty
                                ? Container(
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
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
                          child: Expanded(
                            child: ElevatedButton(
                              child: const Text("Сохранить"),
                              onPressed: () => context
                                  .read<UpdatePlaceBloc>()
                                  .add(UpdatePlace(null!)),
                            ),
                          ),
                        )
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
          .map((image) => GestureDetector(
                onTap: () => setState(() {
                  _isBlurredImageVisible = !_isBlurredImageVisible;
                }),
                child: !_isBlurredImageVisible
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                opacity: 1,
                                image: Image.file(
                                  File(image.path),
                                  fit: BoxFit.cover,
                                ).image)),
                      )
                    : Stack(
                        children: [
                          Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                            // height: 300,
                            // width: 400,
                          ),
                          Container(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                height: 300,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.0)),
                                child: Center(
                                    child: IconButton(
                                        onPressed: () async =>
                                            _displayPickImageDialog(context),
                                        icon: const Icon(
                                          Icons.photo_camera_back_outlined,
                                          color: Colors.white,
                                        ))),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  onPressed: () async => _displayPickImageDialog(context),
                  icon: const Icon(
                    Icons.photo_camera_back_outlined,
                    color: Colors.white,
                  ))),
        )
      ];
    }
  }

  Future _displayPickImageDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Загрузить фото из:',
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () =>
                        _onImageButtonPressed(ImageSource.gallery, context),
                    child: const Text("Галерея")),
                ElevatedButton(
                    onPressed: () =>
                        _onImageButtonPressed(ImageSource.camera, context),
                    child: const Text("Камера")),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future _onImageButtonPressed(ImageSource source, BuildContext context) async {
    try {
      final List<XFile> pickedFile = await _picker.pickMultiImage();
      setState(() {
        _imageFiles = pickedFile;
        _isBlurredImageVisible = false;
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
