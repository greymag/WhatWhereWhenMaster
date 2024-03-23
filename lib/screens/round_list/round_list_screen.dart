import 'package:flutter/material.dart';
import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/application/routes.dart';
import 'package:what_where_when_master/models/round/round.dart';
import 'package:what_where_when_master/screens/home/home_screen.dart';
import 'package:what_where_when_master/screens/round/round_screen.dart';

/// List of game rounds.
class RoundListScreen extends StatelessWidget {
  final List<Round> rounds;

  const RoundListScreen({super.key, required this.rounds});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final roundsCount = rounds.length;

    final loadDataScope = ILoadDataScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.gameTitle),
        actions: [
          if (loadDataScope != null)
            IconButton(
              onPressed: loadDataScope.showLoadDataDialog,
              icon: const Icon(Icons.settings),
            ),
        ],
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
                Navigator.of(context).push(
                  AppRoutes.create<Object>(
                    builder: (context) => RoundScreen(round: round),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
