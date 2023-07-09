import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/models.dart';
import 'package:flutter/material.dart';

class CreatePlaceForm extends StatefulWidget {
  const CreatePlaceForm({super.key});

  @override
  State<CreatePlaceForm> createState() => _CreatePlaceFormState();
}

class _CreatePlaceFormState extends State<CreatePlaceForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String city;
  late String address;

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    hintText: 'Название заведения',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    city = newValue!;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    hintText: 'Город',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    address = newValue!;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    hintText: 'Адрес',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    Navigator.pop(
                        context,
                        CreatePlaceModel(
                          name: name,
                          city: city,
                          address: address,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledForegroundColor:
                          const Color.fromARGB(255, 155, 155, 155),
                      backgroundColor: Constants.mainPurple,
                      disabledBackgroundColor:
                          const Color.fromARGB(255, 45, 45, 45),
                      shape: const StadiumBorder()),
                  child: const SizedBox(
                      height: 50,
                      width: 150,
                      child: Center(
                          child:
                              Text('Создать', style: TextStyle(fontSize: 20)))),
                ),
              ],
            ),
          ],
        ),
      );
}
