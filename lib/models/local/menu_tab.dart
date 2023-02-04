import 'package:flutter/widgets.dart';

enum MenuTab { places, profile, updatePlace }

class MenuTabWrapper {
  final MenuTab tab;
  final Widget child;

  const MenuTabWrapper({
    required this.tab,
    required this.child,
  });
}
