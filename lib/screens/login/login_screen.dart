import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/navigation.dart';
import 'package:booking_app/screens/main/main_screen.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const pageRoute = '/';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String phoneNumber;

  String? validatePhoneNumber(String? value) {
    String pattern = r"^\+375 \(\d{29}|{33}|{44}\) [0-9]{3}-[0-9]{2}-[0-9]{2}$";
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${state.error}')),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Логин'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: "+375 ",
                  keyboardType: TextInputType.phone,
                  onSaved: (newValue) {
                    phoneNumber = newValue!;
                  },
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) {
                    //разобраться почему падает null
                    if (current is LoginSuccess) Navigation.toMain();
                    if (current is LoginError) return false;
                    return true;
                  }, builder: (context, state) {
                    if (state is LoginLoading) {
                      return const ElevatedButton(
                        onPressed: null,
                        child: CupertinoActivityIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context
                                .read<LoginBloc>()
                                .add(LoginStart(phoneNumber));
                          }
                        },
                        child: const Text('Войти'),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
