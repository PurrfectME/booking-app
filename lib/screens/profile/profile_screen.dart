import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const pageRoute = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${state.error}')),
          );
        } else if (state is ProfileSuccess) {
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
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                      buildWhen: (previous, current) {
                    if (current is ProfileSuccess) Navigation.toMain();
                    if (current is ProfileError) return false;
                    return true;
                  }, builder: (context, state) {
                    if (state is ProfileLoading) {
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
                                .read<ProfileBloc>()
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
