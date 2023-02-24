import 'package:booking_app/screens/main/main_screen.dart';
import 'package:booking_app/screens/reservations/reservations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/screens.dart';

// ignore: avoid_classes_with_only_static_members
/// Simple static class to aggregate navigation
class Navigation {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void beforeNavigate() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  /// Navigate to [PlacesScreen]
  static Future<void> toPlaces() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(PlacesScreen.pageRoute, (route) => false);
  }

  /// Navigate to [ReservationsScreen]
  static Future<void> toReservations() {
    beforeNavigate();
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        ReservationsScreen.pageRoute, (route) => false);
  }

  /// Navigate to [MainScreen]
  static Future<void> toMain() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(MainScreen.pageRoute, (route) => false);
  }

  /// Navigate to [LoginScreen]
  static Future<void> toLogin() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(LoginScreen.pageRoute, (route) => false);
  }

  /// Navigate to [ExtraInfoScreen]
  static Future<void> toProfile() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(ExtraInfoScreen.pageRoute, (route) => false);
  }

  /// Navigate to [UpdatePlaceScreen]
  static Future<void> toUpdatePlace() {
    beforeNavigate();
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(UpdatePlaceScreen.pageRoute, (route) => false);
  }
}
