import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => PlacesBloc())
        ],
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.read<PlacesBloc>().add(PlacesLoad());
            }
          },
          child: const MyApp(),
        ))),
    blocObserver: SimpleBlocObserver(),
    eventTransformer: sequential<dynamic>(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Давай заброним',
      home: LoginScreen(),
      locale: Locale('ru', 'RU'),
      supportedLocales: [Locale('ru', 'RU')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
