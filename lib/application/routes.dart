import 'package:WhatWhereWhenMaster/screens/game/game_screen.dart';
import 'package:WhatWhereWhenMaster/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

/// App routes.
class AppRoutes {
  /// See [HomeScreen].
  static const home = "/";

  /// See [GameScreen].
  static const game = "/game";

  /// Строит основной контент по пути.
  static Widget buildByRoute(BuildContext context, String route, Object args) {
    switch (route) {
      case AppRoutes.home:
        return HomeScreen();
      case AppRoutes.game:
        return GameScreen();
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
