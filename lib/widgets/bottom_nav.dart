import 'package:booking_app/models/menu_tab.dart';
import 'package:booking_app/models/nav_item.dart';
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
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 198, 201, 198),
                blurRadius: 15,
                offset: const Offset(0, 4))
          ]),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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

    switch (iconName) {
      case "menu_places":
        icon = Icon(Icons.restaurant);
        break;
      case "menu_profile":
        icon = Icon(Icons.account_box);
        break;
      default:
        //TODO: add default icon
        icon = Icon(Icons.add_box_sharp);
    }

    return BottomNavigationBarItem(
      activeIcon: Icon(icon.icon, color: Colors.blue),
      icon: icon,
      label: title,
    );
  }
}
