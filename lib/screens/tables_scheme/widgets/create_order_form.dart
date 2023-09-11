import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_order_model.dart';
import 'package:flutter/material.dart';

class CreateOrderForm extends StatefulWidget {
  const CreateOrderForm({super.key});

  @override
  State<CreateOrderForm> createState() => _CreateOrderFormState();
}

class _CreateOrderFormState extends State<CreateOrderForm> {
  final _formKey = GlobalKey<FormState>();

  late int guests;
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
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    guests = int.parse(newValue!);
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
                    hintText: 'Количество гостей',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    Navigator.pop(
                        context,
                        CreateOrderModel(
                          guests: guests,
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
                          child: Text('Открыть счёт',
                              style: TextStyle(fontSize: 20)))),
                ),
              ],
            ),
          ],
        ),
      );
}
