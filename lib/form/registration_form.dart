import 'package:flutter/material.dart';

import '../places/places.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String? validatePhoneNumber(String? value) {
    String pattern = r"^\+375 \(\d[29,33,44]\) [0-9]{3}-[0-9]{2}-[0-9]{2}$";
    RegExp regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Введите корреткный номер телефона';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              initialValue: "+375 ",
              keyboardType: TextInputType.phone,
              // onChanged: phoneNumberOnChange,
              // The validator receives the text that the user has entered.
              validator: (value) => validatePhoneNumber(value)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Входим')),
                  );
                  Future.delayed(Duration(seconds: 1)).then((value) =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Places())));
                }
              },
              child: const Text('Войти'),
            ),
          )
        ],
      ),
    );
  }
}
