import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/menu/menu_bloc.dart';
import 'package:booking_app/screens/login/login_screen.dart';
import 'package:booking_app/screens/main/main_screen.dart';
import 'package:booking_app/screens/places/places_screen.dart';
import 'package:booking_app/screens/extra_info/extra_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blocs/simple_bloc_observer.dart';
import 'navigation.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => PlacesBloc()),
          BlocProvider(create: (context) => MenuBloc()),
          BlocProvider(create: (context) => ProfileBloc())
        ],
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              context.read<PlacesBloc>()..add(PlacesLoad());
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
    return MaterialApp(
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
        } else {
          builder ??= (context) => const LoginScreen();
        }

        return MaterialWithModalsPageRoute<void>(
          settings: settings,
          builder: builder,
        );
      },
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
