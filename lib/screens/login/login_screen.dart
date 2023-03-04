import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/navigation.dart';
import 'package:booking_app/screens/extra_info/extra_info_screen.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const pageRoute = '/';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String phoneNumber;

  String? validatePhoneNumber(String? value) {
    const pattern = r'^\+375 \(\d{29}|{33}|{44}\) [0-9]{3}-[0-9]{2}-[0-9]{2}$';
    final regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Введите корреткный номер телефона';
    } else {
      return null;
    }
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${state.error}')),
          );
        } else if (state is LoginSuccess) {
          if (state.user.firstSignIn) {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      ExtraInfoBloc()..add(ExtraInfoLoad(user: state.user)),
                  child: const ExtraInfoScreen(),
                ),
              ),
            );
          } else {
            context.read<PlacesBloc>().add(PlacesLoad());
            Navigation.toMain();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Логин'),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            //TODO: избавиться от всех высот
            height: 200,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.grey.withOpacity(.02),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        initialValue: '+375 ',
                        keyboardType: TextInputType.phone,
                        onSaved: (newValue) {
                          phoneNumber = newValue!;
                        },
                        // onChanged: phoneNumberOnChange,
                        // The validator receives the text that the user has entered.
                        // validator: validatePhoneNumber),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const ElevatedButton(
                                onPressed: null,
                                child: CupertinoActivityIndicator(),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: _onAuthTap,
                                child: const Text('Войти'),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAuthTap() {
// Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<LoginBloc>().add(LoginStart(phoneNumber));
    }
  }
}
