import 'package:booking_app/models/models.dart';
import 'package:booking_app/utils/ext.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(MenuTab tab) onTap;

  const BottomNavigation(
      {required this.currentIndex, required this.items, required this.onTap});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const double iconSize = 24;

  late List<BottomNavigationBarItem> navItems;

  @override
  void initState() {
    navItems = widget.items.map((e) => _navItem(e.iconName, e.title)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Container(
          // margin: const EdgeInsets.fromLTRB(16, 0, 16, 36),
          // padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 50, 50, 50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: navItems
                .mapIndexed((e, index) => Expanded(
                        child: InkWell(
                      onTap: () => widget.onTap(widget.items[index].tab),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.currentIndex == index)
                              e.activeIcon
                            else
                              e.icon,
                            const SizedBox(height: 4),
                            DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                              child: Text(e.label ?? ''),
                            )
                          ],
                        ),
                      ),
                    )))
                .toList(),
          ),
        ),
      );

  BottomNavigationBarItem _navItem(String iconName, String title) {
    Icon icon;
    const inactiveIconColor = Color.fromARGB(255, 95, 95, 95);

    switch (iconName) {
      case "menu_places":
        icon = const Icon(Icons.restaurant, color: inactiveIconColor);
        break;
      case "menu_profile":
        icon = const Icon(Icons.account_box, color: inactiveIconColor);
        break;
      case "menu_update_place":
        icon = const Icon(Icons.add, color: inactiveIconColor);
        break;
      default:
        //TODO: add default icon
        icon = const Icon(Icons.add_box_sharp, color: inactiveIconColor);
    }

    return BottomNavigationBarItem(
      activeIcon: Icon(icon.icon, color: Colors.white),
      icon: icon,
      label: title,
    );
  }
}
