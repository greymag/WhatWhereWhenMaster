import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import 'package:WhatWhereWhenMaster/application/localization.dart';

/// Timer for round view.
class RoundTimerView extends StatefulWidget {
  /// Timer value.
  final Duration value;

  /// Remaining, when timer is changing color.
  final Duration alertRemaining;

  const RoundTimerView(
      {Key key, @required this.value, @required this.alertRemaining})
      : assert(value != null),
        assert(alertRemaining != null),
        super(key: key);

  @override
  _RoundTimerViewState createState() => _RoundTimerViewState();
}

class _RoundTimerViewState extends State<RoundTimerView> {
  CountdownTimer _timer;
  Duration _duration;

  @override
  void initState() {
    _duration = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final duration = _duration;
    final alertRemaining = widget.alertRemaining;
    final isRunning = _timer != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TimerControlButton(
          child: Text(loc.timerResetBtn),
          onPressed: _resetTimer,
        ),
        isRunning
            ? _RunningTimerValue(
                timer: _timer,
                alertRemaining: alertRemaining,
              )
            : _TimerValue(
                duration: duration,
                alertRemaining: alertRemaining,
              ),
        isRunning
            ? _TimerControlButton(
                child: Text(loc.timerStopBtn),
                onPressed: _stopTimer,
              )
            : _TimerControlButton(
                child: Text(loc.timerStartBtn),
                onPressed: _startTimer,
              ),
      ],
    );
  }

  void _resetTimer() {
    if (_timer != null || _duration != widget.value) {
      setState(() {
        _timer?.cancel();
        _timer = null;
        _duration = widget.value;
      });
    }
  }

  void _startTimer() {
    if (_timer == null) {
      setState(() {
        _timer = CountdownTimer(_duration, const Duration(seconds: 1));
      });
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      setState(() {
        _duration = _timer.remaining;
        _timer.cancel();
        _timer = null;
      });
    }
  }
}

class _RunningTimerValue extends StatefulWidget {
  final CountdownTimer timer;
  final Duration alertRemaining;

  const _RunningTimerValue(
      {Key key, @required this.timer, @required this.alertRemaining})
      : assert(timer != null),
        assert(alertRemaining != null),
        super(key: key);

  @override
  _RunningTimerValueState createState() => _RunningTimerValueState();
}

class _RunningTimerValueState extends State<_RunningTimerValue> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.timer,
      initialData: widget.timer,
      builder: (context, AsyncSnapshot<CountdownTimer> snapshot) {
        // TODO: alert sound
        return _TimerValue(
          duration: snapshot.data.remaining,
          alertRemaining: widget.alertRemaining,
        );
      },
    );
  }
}

class _TimerValue extends StatelessWidget {
  static const _alertColor = Colors.red;

  final Duration duration;
  final Duration alertRemaining;

  const _TimerValue(
      {Key key, @required this.duration, @required this.alertRemaining})
      : assert(duration != null),
        assert(alertRemaining != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAlert = duration <= alertRemaining;
    return Text(
      loc.getTimerValue(duration),
      style: TextStyle(
        color: isAlert ? _alertColor : null,
      ),
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
