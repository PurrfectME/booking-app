import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/screens/screens.dart';
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

  late String email;
  late String password;

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
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка: ${state.error}')),
            );
          } else if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                    builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => DashboardBloc()
                                ..add(DashboardLoad(userId: state.user.id!)),
                            ),
                            BlocProvider(
                                create: (context) => TablesBloc(placeId: 1)),
                            BlocProvider(
                                create: (context) => ReservationsBloc()),
                            BlocProvider(
                                create: (context) => TableReservationsBloc([])
                                  ..add(
                                      const TableReservationsLoad(placeId: 1))),
                            BlocProvider(create: (context) => MenuBloc()),
                            BlocProvider(create: (context) => DishBloc()),
                            BlocProvider(create: (context) => ProductBloc()),
                            BlocProvider(create: (context) => KitchenBloc()),
                          ],
                          child: const DashboardScreen(),
                        )),
                (route) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('UReserve'),
          ),
          body: Center(
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 30),
              //TODO: избавиться от всех высот
              height: 570,
              width: 490,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 23, 23),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Вход',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            initialValue: '',
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) {
                              email = newValue!;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Constants.mainPurple, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    width: 2),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66)),
                              hintText: 'Ваш Логин или E-mail',
                            ),
                            // onChanged: phoneNumberOnChange,
                            // The validator receives the text that the user has entered.
                            // validator: validatePhoneNumber),
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            initialValue: '',
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              password = newValue!;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Constants.mainPurple, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    width: 2),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66)),
                              hintText: 'Ваш пароль',
                            ),
                            // onChanged: phoneNumberOnChange,
                            // The validator receives the text that the user has entered.
                            // validator: validatePhoneNumber),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Забыли пароль',
                                style: TextStyle(
                                    decorationStyle: TextDecorationStyle.solid,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    color: Color.fromARGB(255, 155, 155, 155)),
                              )
                            ],
                          ),
                          const SizedBox(height: 60),
                          ElevatedButton(
                            onPressed: _onLoginTap,
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
                                    child: Text('Войти',
                                        style: TextStyle(fontSize: 20)))),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: TextButton(
                          onPressed: _onRegisterTap,
                          child: const Text('Нет аккаунта? Зарегистрируйтесь'),
                          // style: ButtonStyle(
                          //   textStyle: ,
                          //     decorationStyle: TextDecorationStyle.solid,
                          //     decoration: TextDecoration.underline,
                          //     decorationThickness: 2,
                          //     color: const Color.fromARGB(255, 155, 155, 155)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onLoginTap() {
// Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthBloc>().add(LoginStart(
            email: email,
            password: password,
          ));
    }
  }

  void _onRegisterTap() {
    context.read<AuthBloc>().add(RegistrationLoad());
    Navigator.push<void>(context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }
}
