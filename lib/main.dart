import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/menu/menu_bloc.dart';
import 'package:booking_app/blocs/reserve_table/reserve_table_bloc.dart';
import 'package:booking_app/screens/main/main_screen.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blocs/simple_bloc_observer.dart';
import 'navigation.dart';

void main() {
  //TODO: initialize DbProvider here to create it on app init
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  Bloc.observer = SimpleBlocObserver();
  Bloc.transformer = sequential<dynamic>();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginBloc()),
      BlocProvider(create: (context) => PlacesBloc()),
      BlocProvider(create: (context) => MenuBloc()),
      // BlocProvider(create: (context) => PlaceInfoBloc(null)),
      BlocProvider(create: (context) => ExtraInfoBloc()),
      // BlocProvider(create: (context) => TableInfoBloc()),
      // BlocProvider(create: (context) => ReserveTableBloc()),
      // BlocProvider(create: (context) => ReservationsBloc()),
      // BlocProvider(create: (context) => ReservationInfoBloc()),
      // BlocProvider(create: (context) => UpdatePlaceBloc()),
      // BlocProvider(create: (context) => UpdateTableBloc()),
      // BlocProvider(create: (context) => ReservationsBloc([])),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            platform: TargetPlatform.iOS,
            // primaryColor: Colors.black,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              color: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                // height: 22,
                // letterSpacing: -0.5%
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
            ),
            // backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.white,
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

          if (path == PlacesScreen.pageRoute) {
            builder = (context) => const PlacesScreen();
          } else if (path == LoginScreen.pageRoute) {
            builder = (context) => const LoginScreen();
          } else if (path == ExtraInfoScreen.pageRoute) {
            builder = (context) => const ExtraInfoScreen();
          } else if (path == MainScreen.pageRoute) {
            builder = (context) => const MainScreen();
          } else if (path == UpdatePlaceScreen.pageRoute) {
            builder = (context) => const UpdatePlaceScreen();
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
