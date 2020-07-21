import 'package:WhatWhereWhenMaster/application/routes.dart';
import 'package:flutter/material.dart';

/// Home screen.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.game);
          },
          child: Icon(
            Icons.play_arrow,
            size: 100,
          ),
          color: Colors.cyan,
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
