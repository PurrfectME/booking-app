import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future displayImagePickerBox(BuildContext context, Function setImageSource) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Загрузить фото из:',
            style: TextStyle(color: Colors.black),
          ),
          content: SizedBox(
            height: 99,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () =>
                        setImageSource(ImageSource.gallery, context),
                    child: const Text('Галерея')),
                ElevatedButton(
                    onPressed: () =>
                        setImageSource(ImageSource.camera, context),
                    child: const Text('Камера')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  static Image imageFromBase64String(String? base64String) {
    if (base64String == null) {
      //TODO: add default image
      return Image.asset('assets/images/neft.jpg');
    }
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  static Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  static String base64String(Uint8List data) => base64Encode(data);
}
