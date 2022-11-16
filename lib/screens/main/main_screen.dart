import 'package:booking_app/blocs/menu/menu_bloc.dart';
import 'package:booking_app/models/menu_tab.dart';
import 'package:booking_app/models/nav_item.dart';
import 'package:booking_app/screens/login/login_screen.dart';
import 'package:booking_app/screens/places/places_screen.dart';
import 'package:booking_app/screens/profile/profile_screen.dart';
import 'package:booking_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const pageRoute = '/main';

  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final pages = <MenuTabWrapper>[
    const MenuTabWrapper(
      tab: MenuTab.places,
      child: PlacesScreen(key: Key('PlacesScreen')),
    ),
    const MenuTabWrapper(
      tab: MenuTab.profile,
      child: ProfileScreen(key: Key('ProfileScreen')),
    ),
    const MenuTabWrapper(
      tab: MenuTab.login,
      child: LoginScreen(key: Key('LoginScreen')),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) => Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: pages.indexWhere((e) => e.tab == state.tab),
            children: pages.map((e) => e.child).toList(),
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: pages.indexWhere((e) => e.tab == state.tab),
            onTap: (tab) {
              // if (tab == MenuTab.qrScan) {
              //   Navigation.toQrScan(context: context);
              // } else {
              context.read<MenuBloc>().add(MenuTabUpdate(tab));
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const NavItem(
                iconName: 'menu_history',
                title: "Рестораны",
                tab: MenuTab.places,
              ),
              // const NavItem(
              //   iconName: 'menu_history',
              //   title: "Логин",
              //   tab: MenuTab.Login,
              // ),
              const NavItem(
                iconName: 'menu_accounts',
                title: "Профиль",
                tab: MenuTab.profile,
              )
            ],
          ),
        ),
      );

  // Widget mapTabToScreen(MenuState tab) {
  //   var id = 0;
  //   if (tab is MenuTabHome) {
  //     id = 0;
  //   } else if (tab is MenuTabHistory) {
  //     id = 1;
  //   } else if (tab is MenuTabAccounts) {
  //     id = 2;
  //   } else if (tab is MenuTabProfile) {
  //     id = 3;
  //   }
  //   return pages[id];
  //   // Widget screen = HomeScreen(key: PageStorageKey('HomeScreen'));
  //   // if (tab is TabHome) {
  //   //   screen = HomeScreen(key: PageStorageKey('HomeScreen'));
  //   // }
  //   // if (tab is TabHistory) {
  //   //   screen = HistoryScreen(key: PageStorageKey('HistoryScreen'));
  //   // }
  //   // if (tab is TabAccounts) {
  //   //   screen = AccountsScreen(key: PageStorageKey('AccountsScreen'));
  //   // }
  //   // if (tab is TabProfile) {
  //   //   screen = ProfileScreen(key: PageStorageKey('ProfileScreen'));
  //   // }
  //   // return PageStorage(
  //   //   child: screen,
  //   //   bucket: _bucket,
  //   // );
  // }
}
