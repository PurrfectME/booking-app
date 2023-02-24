import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/models.dart';
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
  late UserModel localObj;

  @override
  Widget build(BuildContext context) =>
      BlocListener<ExtraInfoBloc, ExtraInfoState>(
        listener: (context, state) {
          if (state is ExtraInfoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка: ${state.error}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Регистрация'),
          ),
          body: BlocBuilder<ExtraInfoBloc, ExtraInfoState>(
            builder: (context, state) {
              if (state is ExtraInfoLoading) {
                return Center(
                  child: CupertinoActivityIndicator(radius: 20),
                );
              } else if (state is ExtraInfoLoaded) {
                localObj = state.user;
                return Center(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
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
                            const Text('Как мне называть тебя?'),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              onSaved: (newValue) {
                                name = newValue;
                              },
                              onChanged: (value) {
                                localObj = localObj.copyWith(
                                  name: value,
                                );
                              },
                              // The validator receives the text that the user has entered.
                              // validator: validatePhoneNumber),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      context.read<ExtraInfoBloc>().add(
                                          UpdateProfileName(user: localObj));
                                    }
                                  },
                                  child: const Text('Продолжить'),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      );
}
