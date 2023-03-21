import 'package:flutter/material.dart';

class NavigationArguments {
  late int coffee;
  late int? dessert;
  late bool isSweet;
  late bool isCheckout;
  NavigationArguments(
      {required this.coffee,
      this.dessert,
      this.isCheckout = false,
      this.isSweet = false});
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late HeroController heroController;
  NavigationService() {
    heroController = HeroController(createRectTween: _createRectTween);
  }
  // ignore: non_constant_identifier_names
  void NavigateTo(NavigationArguments args) {
    navigatorKey.currentState!.pushNamed('', arguments: args);
  }

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }
}
