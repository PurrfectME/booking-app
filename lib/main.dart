import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/menu/menu_bloc.dart';
import 'package:booking_app/screens/main/main_screen.dart';
import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'blocs/simple_bloc_observer.dart';
import 'navigation.dart';

void main() {
  //TODO: initialize DbProvider here to create it on app init
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => PlacesBloc()),
          BlocProvider(create: (context) => MenuBloc()),
          BlocProvider(create: (context) => ExtraInfoBloc()),
          BlocProvider(create: (context) => UpdatePlaceBloc()),
        ],
        child: BlocListener<ExtraInfoBloc, ExtraInfoState>(
          listener: (context, state) {
            if (state is ExtraInfoSuccess) {
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
    return MaterialApp(
      theme: ThemeData(
          platform: TargetPlatform.iOS,
          // primaryColor: Colors.black,
          // appBarTheme: AppBarTheme(backgroundColor: Colors.black),
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
}
