import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blocs/simple_bloc_observer.dart';
import 'navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveProvider.initHive();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  Bloc.observer = SimpleBlocObserver();
  Bloc.transformer = sequential<dynamic>();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => ExtraInfoBloc()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            // primaryColor: Colors.black,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              centerTitle: true,
              color: Constants.mainPurple,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                // height: 22,
                // letterSpacing: -0.5%
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
            ),
            // backgroundColor: Colors.black,
            scaffoldBackgroundColor: const Color.fromARGB(255, 16, 16, 16),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                )),
        navigatorKey: Navigation.navigatorKey,
        title: 'Давай заброним',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final path = settings.name;

          Widget Function(BuildContext)? builder;

          if (path == LoginScreen.pageRoute) {
            builder = (context) => const LoginScreen();
          } else if (path == ExtraInfoScreen.pageRoute) {
            builder = (context) => const ExtraInfoScreen();
          } else if (path == UpdatePlaceScreen.pageRoute) {
            builder = (context) => const UpdatePlaceScreen();
          } else if (path == RegistrationScreen.pageRoute) {
            builder = (context) => const RegistrationScreen();
          } else {
            builder ??= (context) => const LoginScreen();
          }

          return MaterialWithModalsPageRoute<void>(
            settings: settings,
            builder: builder,
          );
        },
        locale: const Locale('ru', 'RU'),
        supportedLocales: const [Locale('ru', 'RU')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
}
