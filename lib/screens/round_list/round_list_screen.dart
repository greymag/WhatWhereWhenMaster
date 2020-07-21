import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/application/routes.dart';
import 'package:WhatWhereWhenMaster/models/round/round.dart';
import 'package:WhatWhereWhenMaster/screens/round/round_screen.dart';
import 'package:flutter/material.dart';

/// List of game rounds.
class RoundListScreen extends StatelessWidget {
  final List<Round> rounds;

  const RoundListScreen({Key key, @required this.rounds})
      : assert(rounds != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final roundsCount = rounds.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.gameTitle),
      ),
      body: ListView(
        children: <Widget>[
          for (final round in rounds)
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              title: Text(
                loc.getRoundTitle(round, roundsCount),
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(AppRoutes.create(
                  builder: (context) => RoundScreen(round: round),
                ));
              },
            ),
        ],
      ),
    );
  }
}
