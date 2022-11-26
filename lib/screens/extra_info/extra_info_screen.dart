import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraInfoScreen extends StatefulWidget {
  static const pageRoute = '/extra-info';
  const ExtraInfoScreen({super.key});

  @override
  State<ExtraInfoScreen> createState() => _ExtraInfoScreenState();
}

class _ExtraInfoScreenState extends State<ExtraInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExtraInfoBloc, ExtraInfoState>(
      listener: (context, state) {
        if (state is ExtraInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${state.error}')),
          );
        } else if (state is ExtraInfoSuccess) {
          Navigation.toMain();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Как мне называть тебя?"),
                TextFormField(
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) {
                    name = newValue;
                  },
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BlocBuilder<ExtraInfoBloc, ExtraInfoState>(
                      buildWhen: (previous, current) {
                    if (current is ExtraInfoSuccess) Navigation.toMain();
                    if (current is ExtraInfoError) return false;
                    return true;
                  }, builder: (context, state) {
                    if (state is ExtraInfoLoading) {
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
                                .read<ExtraInfoBloc>()
                                .add(AddProfileName(name!));
                          }
                        },
                        child: const Text('Продолжить'),
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