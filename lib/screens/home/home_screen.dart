import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
