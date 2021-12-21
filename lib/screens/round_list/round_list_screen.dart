import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/application/routes.dart';
import 'package:what_where_when_master/models/round/round.dart';
import 'package:what_where_when_master/screens/round/round_screen.dart';
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
                style: const TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(AppRoutes.create<Object>(
                  builder: (context) => RoundScreen(round: round),
                ));
              },
            ),
        ],
      ),
    );
  }
}
