import 'menu_tab.dart';

class NavItem {
  final String iconName;
  final String title;
  final MenuTab tab;

  const NavItem(
      {required this.iconName, required this.title, required this.tab});
}
