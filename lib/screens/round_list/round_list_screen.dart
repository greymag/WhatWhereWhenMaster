import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/models/round/round.dart';
import 'package:flutter/material.dart';
import 'package:innim_lib/innim_lib.dart';

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
    return ListView(
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
              // TODO: navigate to round view
              debugLog("Tap on $round");
            },
          ),
      ],
    );
  }
}
