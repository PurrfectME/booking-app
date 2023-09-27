import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/db/measure.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/utils/measure_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  late String name;
  late double amount;
  late String measure;
//TODO: валидация на добавление продукта который уже существует
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
                    labelText: 'Название продукта',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onSaved: (newValue) {
                    amount = double.parse(newValue!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Количество',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(color: Colors.white),
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                      labelText: 'Мера',
                      floatingLabelStyle: const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 66, 66, 66)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Constants.mainPurple, width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 66, 66, 66), width: 2),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) => Measure.values
                      .map(MeasureHelper.fromMeasure)
                      .where((measure) => measure
                          .toLowerCase()
                          .contains(pattern.toLowerCase())),
                  itemBuilder: (context, suggestion) => ListTile(
                    title: Text(suggestion),
                  ),
                  onSuggestionSelected: (suggestion) {
                    _typeAheadController.text = suggestion;
                    setState(() {
                      measure = suggestion;
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                Navigator.pop(context,
                    ProductModel(name: name, amount: amount, type: measure));
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
                      child: Text('Создать', style: TextStyle(fontSize: 20)))),
            ),
          ],
        ),
      );
}
