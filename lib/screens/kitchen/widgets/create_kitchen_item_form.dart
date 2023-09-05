import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/kitchen_model.dart';
import 'package:flutter/material.dart';

class CreateKitchenItemForm extends StatefulWidget {
  const CreateKitchenItemForm({super.key});

  @override
  State<CreateKitchenItemForm> createState() => _CreateKitchenItemFormState();
}

class _CreateKitchenItemFormState extends State<CreateKitchenItemForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double amount;
  late String user;

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
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    user = newValue!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Юзер',
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
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                Navigator.pop(
                    context,
                    KitchenModel(
                        id: 0,
                        name: name,
                        amount: amount,
                        user: user,
                        date: DateTime.now().millisecondsSinceEpoch));
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
