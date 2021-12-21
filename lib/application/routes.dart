import 'package:what_where_when_master/models/models.dart';
import 'package:what_where_when_master/screens/game/game_screen.dart';
import 'package:what_where_when_master/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

/// App routes.
class AppRoutes {
  /// See [HomeScreen].
  static const home = '/';

  /// See [GameScreen].
  static const game = '/game';

  /// Строит основной контент по пути.
  static Widget buildByRoute(BuildContext context, String route, Object args) {
    switch (route) {
      case AppRoutes.home:
        return const HomeScreen();
      case AppRoutes.game:
        assert(args is GameData);
        return GameScreen(game: args as GameData);
    }

    throw Exception('Unknown route: $route');
  }

  /// Creates [Route] by path string.
  static Route<T> createRoute<T>(String route, {RouteSettings settings}) {
    return create<T>(
        builder: (ctx) =>
            AppRoutes.buildByRoute(ctx, route, settings.arguments),
        settings: settings);
  }

  /// Creates default route with builder.
  static Route<T> create<T>({WidgetBuilder builder, RouteSettings settings}) {
    return MaterialPageRoute<T>(builder: builder, settings: settings);
  }

  AppRoutes._();
}
