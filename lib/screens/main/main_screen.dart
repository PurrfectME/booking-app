import 'package:booking_app/blocs/menu/menu_bloc.dart';
import 'package:booking_app/models/local/menu_tab.dart';
import 'package:booking_app/models/local/nav_item.dart';
import 'package:booking_app/screens/screens.dart';
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
      tab: MenuTab.profile,
      child: ExtraInfoScreen(key: Key('ProfileScreen')),
    ),
    const MenuTabWrapper(
      tab: MenuTab.updatePlace,
      child: UpdatePlaceScreen(key: Key('UpdatePlaceScreen')),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) => Scaffold(
          // extendBody: true,
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: pages.indexWhere((e) => e.tab == state.tab),
            children: pages.map((e) => e.child).toList(),
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: pages.indexWhere((e) => e.tab == state.tab),
            onTap: (tab) {
              context.read<MenuBloc>().add(MenuTabUpdate(tab));
            },
            items: const [
              NavItem(
                iconName: 'menu_places',
                title: 'Рестораны',
                tab: MenuTab.places,
              ),
              NavItem(
                iconName: 'menu_profile',
                title: 'Профиль',
                tab: MenuTab.profile,
              ),
              NavItem(
                iconName: 'menu_update_place',
                title: 'Заведение',
                tab: MenuTab.updatePlace,
              )
            ],
          ),
        ),
      );
}
