import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import 'package:WhatWhereWhenMaster/application/localization.dart';

/// Timer for round view.
class RoundTimerView extends StatefulWidget {
  /// Timer value.
  final Duration value;

  /// Remaining, when timer is changing color.
  final Duration alertRemaining;

  /// Callback to be called when the timer is complete.
  final VoidCallback onTimerComplete;

  const RoundTimerView(
      {Key key,
      @required this.value,
      @required this.alertRemaining,
      @required this.onTimerComplete})
      : assert(value != null),
        assert(alertRemaining != null),
        assert(onTimerComplete != null),
        super(key: key);

  @override
  _RoundTimerViewState createState() => _RoundTimerViewState();
}

class _RoundTimerViewState extends State<RoundTimerView> {
  CountdownTimer _timer;
  Duration _duration;

  StreamSubscription<CountdownTimer> _subscription;

  @override
  void initState() {
    _duration = widget.value;

    super.initState();
  }

  @override
  void dispose() {
    _clearTimer();
    super.dispose();
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
                onPressed: duration.inMilliseconds < 10 ? null : _startTimer,
              ),
      ],
    );
  }

  void _resetTimer() {
    if (_timer != null || _duration != widget.value) {
      setState(() {
        _clearTimer();
        _duration = widget.value;
      });
    }
  }

  void _startTimer() {
    if (_timer == null) {
      setState(() {
        _timer = CountdownTimer(_duration, const Duration(seconds: 1));
        _subscription = _timer.listen((timer) {}, onDone: () {
          _stopTimer();
          widget.onTimerComplete();
        });
      });
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      setState(() {
        _duration = _timer.remaining;
        _clearTimer();
      });
    }
  }

  void _clearTimer() {
    _subscription?.cancel();
    _subscription = null;
    _timer?.cancel();
    _timer = null;
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
    return StreamBuilder<CountdownTimer>(
      stream: widget.timer,
      initialData: widget.timer,
      builder: (context, snapshot) {
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
        fontSize: 100,
        fontWeight: FontWeight.w200,
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
    final textStyle = Theme.of(context).textTheme.button;
    return RawMaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
      textStyle: textStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      constraints: const BoxConstraints(minWidth: 150, minHeight: 150),
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.lightGreenAccent.shade400,
          width: 2,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
