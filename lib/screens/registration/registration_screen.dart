import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  static const pageRoute = '/registration';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String confirmedPassword;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            //push to dashboard
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
                                  ..add(TableReservationsLoad())),
                            BlocProvider(create: (context) => MenuBloc()),
                            BlocProvider(create: (context) => DishBloc()),
                            BlocProvider(create: (context) => ProductBloc()),
                            BlocProvider(create: (context) => KitchenBloc()),
                            BlocProvider(create: (context) => OrderBloc()),
                          ],
                          child: const DashboardScreen(),
                        )),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is RegistrationLoaded) {
            return Scaffold(
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
                                'Регистрация',
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
                                          color: Constants.mainPurple,
                                          width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        width: 2),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 66, 66, 66)),
                                  hintText: 'Ваш E-mail',
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
                                          color: Constants.mainPurple,
                                          width: 2)),
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
                              const SizedBox(height: 40),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                initialValue: '',
                                keyboardType: TextInputType.text,
                                onSaved: (newValue) {
                                  confirmedPassword = newValue!;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Constants.mainPurple,
                                          width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        width: 2),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 66, 66, 66)),
                                  hintText: 'Повторите пароль',
                                ),
                                // onChanged: phoneNumberOnChange,
                                // The validator receives the text that the user has entered.
                                // validator: validatePhoneNumber),
                              ),
                              const SizedBox(height: 60),
                              ElevatedButton(
                                onPressed: _onRegistrationTap,
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    disabledForegroundColor:
                                        const Color.fromARGB(
                                            255, 155, 155, 155),
                                    backgroundColor: Constants.mainPurple,
                                    disabledBackgroundColor:
                                        const Color.fromARGB(255, 45, 45, 45),
                                    shape: const StadiumBorder()),
                                child: const SizedBox(
                                    height: 50,
                                    width: 250,
                                    child: Center(
                                        child: Text('Зарегистрироваться',
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: const Text(
                              'Или войдите в свой аккаунт',
                              style: TextStyle(
                                  decorationStyle: TextDecorationStyle.solid,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  color:
                                      const Color.fromARGB(255, 155, 155, 155)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _onRegistrationTap() {
// Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthBloc>().add(RegistrationStart(
            email: email,
            password: password,
          ));
    }
  }
}
