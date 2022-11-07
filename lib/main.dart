import 'package:booking_app/form/registration_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Давай заброним',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Давай заброним'),
          ),
          body: const RegistrationForm()),
    );
  }
}
