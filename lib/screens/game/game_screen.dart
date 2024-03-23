import 'package:flutter/material.dart';

import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/models/models.dart';

import 'game_tab.dart';

/// Game screen.
///
/// Shows rounds of the game, notes and rules.
class GameScreen extends StatefulWidget {
  /// Data of the game.
  final GameData game;

  const GameScreen({super.key, required this.game});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: _buildBodyByTab(context, _currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (value) {
          if (_currentTabIndex != value) {
            setState(() {
              _currentTabIndex = value;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.casino),
            label: loc.bottomNavigationTabGame,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.comment),
            label: loc.bottomNavigationTabNotes,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.gavel),
            label: loc.bottomNavigationTabRules,
          ),
        ],
      ),
    );
  }

  Widget _buildBodyByTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        return GameTab(game: widget.game);
      case 1:
        return Container();
      case 2:
        return Container();
    }

    assert(false, 'Unhandled tab index: $index');
    return Container();
  }
}
