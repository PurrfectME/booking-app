import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future displayImagePickerBox(BuildContext context, Function setImageSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Загрузить фото из:',
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: 99,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () =>
                          setImageSource(ImageSource.gallery, context),
                      child: const Text("Галерея")),
                  ElevatedButton(
                      onPressed: () =>
                          setImageSource(ImageSource.camera, context),
                      child: const Text("Камера")),
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
          );
        });
  }
}
