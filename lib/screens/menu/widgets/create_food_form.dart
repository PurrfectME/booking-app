import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_food.dart';
import 'package:flutter/material.dart';

class CreateFoodForm extends StatefulWidget {
  const CreateFoodForm({super.key});

  @override
  State<CreateFoodForm> createState() => _CreateFoodFormState();
}

class _CreateFoodFormState extends State<CreateFoodForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late List<String> tags;

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
                    hintText: 'Название блюда',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '0',
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onSaved: (newValue) {
                    price = double.parse(newValue!);
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
                    hintText: 'Цена',
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
                    final separated = newValue!.split(' ');
                    tags = separated;
                  },
                  decoration: InputDecoration(
                    labelText: 'Теги для поиска',
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
                    hintText: 'Вводить через пробел',
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
                        CreateFoodModel(
                          name: name,
                          price: price,
                          tags: tags,
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
