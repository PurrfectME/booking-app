import 'dart:io';
import 'dart:ui';

import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/table_vm.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../old_tables/tables_screen.dart';

class UpdatePlaceScreen extends StatefulWidget {
  static const pageRoute = '/update-place';
  const UpdatePlaceScreen({super.key});

  @override
  State<UpdatePlaceScreen> createState() => _UpdatePlaceScreenState();
}

class _UpdatePlaceScreenState extends State<UpdatePlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  bool _isBlurredImageVisible = false;
  late PlaceModel localObj;

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
  Widget build(BuildContext context) =>
      BlocListener<UpdatePlaceBloc, UpdatePlaceState>(
        listener: (context, state) {
          if (state is UpdatePlaceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Заведение сохранено')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Редактирование ресторана')),
          body: BlocBuilder<UpdatePlaceBloc, UpdatePlaceState>(
            builder: (context, state) {
              if (state is UpdatePlaceLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: CupertinoActivityIndicator(radius: 20)),
                  ],
                );
              } else if (state is UpdatePlaceError) {
                return Text(state.error);
              } else if (state is UpdatePlaceLoaded) {
                localObj = state.data;
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                    initialValue: state.data.name,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        labelText: 'Название',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    keyboardType: TextInputType.text,
                                    onSaved: (newValue) {
                                      localObj =
                                          localObj.copyWith(name: newValue!);
                                    },
                                    onChanged: (value) => localObj =
                                        localObj.copyWith(name: value)
                                    // The validator receives the text that the user has entered.
                                    // validator: validatePhoneNumber),
                                    ),
                                TextFormField(
                                  initialValue: state.data.description,
                                  onSaved: (newValue) {
                                    localObj = localObj.copyWith(
                                        description: newValue!);
                                  },
                                  onChanged: (value) => localObj =
                                      localObj.copyWith(description: value),
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      labelText: 'Описание',
                                      labelStyle:
                                          TextStyle(color: Colors.black)),
                                  keyboardType: TextInputType.text,
                                ),
                                _previewImages(state.data.base64Logo),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  child: const Text('Столы'),
                                  onPressed: () =>
                                      _onTablesUpdateTap(state.data),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SafeArea(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: _onSaveTap,
                              child: const Text('Сохранить'),
                            ),
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

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages(String? base64Logo) {
    if (base64Logo != null) {
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => setState(() {
                _isBlurredImageVisible = !_isBlurredImageVisible;
              }),
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 300,
              width: 400,
              child: ImageService.imageFromBase64String(base64Logo)));
    }

    final retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => setState(() {
          _isBlurredImageVisible = !_isBlurredImageVisible;
        }),
        child: !_isBlurredImageVisible
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 300,
                width: 400,
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                ),
              )
            : Stack(
                children: [
                  Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                    height: 300,
                    width: 400,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: 300,
                      width: 400,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0)),
                      child: Center(
                        child: IconButton(
                          onPressed: _onImageButtonPressed,
                          icon: const Icon(
                            Icons.photo_camera_back_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
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
      );
    }
  }

  Future _onImageButtonPressed() async {
    final source = await ImageService().displayImagePickerBox(context);
    if (source != null) {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        final imageBytes = await pickedFile?.readAsBytes();
        setState(() {
          _imageFile = pickedFile;
          _isBlurredImageVisible = false;

          if (imageBytes != null) {
            localObj = localObj.copyWith(
                base64Logo: ImageService.base64String(imageBytes));
          }
        });
        // Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
        // Navigator.of(context).pop();
      }
    }
  }

  Future<void> retrieveLostData() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _onTablesUpdateTap(PlaceModel place) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => TablesBloc(
            placeId: place.id,
          )..add(const TablesLoad()),
          child: const TablesScreen(),
        ),
      ),
    );
  }

  void _onSaveTap() {
    context.read<UpdatePlaceBloc>().add(UpdatePlace(localObj));
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
