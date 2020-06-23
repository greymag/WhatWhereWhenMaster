import 'package:WhatWhereWhenMaster/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App routes.
class AppRoutes {
  static const home = "/";

  /// Строит основной контент по пути.
  static Widget buildByRoute(BuildContext context, String route, Object args) {
    switch (route) {
      case AppRoutes.home:
        return HomeScreen();
    }

    throw Exception('Unknown route: $route');
  }

  /// Создает [Route] по строке пути.
  static Route<T> createRoute<T>(String route, {RouteSettings settings}) {
    return MaterialPageRoute(
        builder: (ctx) =>
            AppRoutes.buildByRoute(ctx, route, settings.arguments),
        settings: settings);
  }

  AppRoutes._();
}
