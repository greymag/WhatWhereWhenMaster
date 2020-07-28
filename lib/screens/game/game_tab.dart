import 'package:WhatWhereWhenMaster/application/routes.dart';
import 'package:flutter/material.dart';

import 'package:WhatWhereWhenMaster/models/game_data/game_data.dart';
import 'package:WhatWhereWhenMaster/screens/round_list/round_list_screen.dart';

/// Game tab for a [GameScreen].
class GameTab extends StatelessWidget {
  final GameData game;

  const GameTab({Key key, @required this.game})
      : assert(game != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == Navigator.defaultRouteName) {
          return AppRoutes.create<Object>(
            builder: (context) => RoundListScreen(rounds: game.rounds),
            settings: settings,
          );
        }

        return Navigator.of(context, rootNavigator: true)
            .widget
            .onGenerateRoute(settings);
      },
    );
  }
}
