import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:flutter/material.dart';

/// Game screen.
///
/// Shows rounds of the game, notes and rules.
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.gameTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            title: Text(loc.bottomNavigationTabGame),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            title: Text(loc.bottomNavigationTabNotes),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            title: Text(loc.bottomNavigationTabRules),
          ),
        ],
      ),
    );
  }
}
