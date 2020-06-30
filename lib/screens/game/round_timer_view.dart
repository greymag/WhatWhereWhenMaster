import 'package:flutter/material.dart';

import 'package:WhatWhereWhenMaster/application/localization.dart';

/// Timer for round view.
class RoundTimerView extends StatefulWidget {
  final Duration value;

  const RoundTimerView({Key key, @required this.value})
      : assert(value != null),
        super(key: key);

  @override
  _RoundTimerViewState createState() => _RoundTimerViewState();
}

class _RoundTimerViewState extends State<RoundTimerView> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final duration = widget.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TimerControlButton(
          child: Text(loc.timerResetBtn),
          onPressed: () {
            // TODO: reset timer
          },
        ),
        Text(loc.getTimerValue(duration)),
        _TimerControlButton(
          child: Text(loc.timerStartBtn),
          onPressed: () {
            // TODO: reset timer
          },
        ),
      ],
    );
  }
}

class _TimerControlButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _TimerControlButton(
      {Key key, @required this.child, @required this.onPressed})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
