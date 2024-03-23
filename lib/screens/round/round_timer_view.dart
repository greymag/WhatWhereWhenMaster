import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import 'package:what_where_when_master/application/localization.dart';

/// Timer for round view.
class RoundTimerView extends StatefulWidget {
  /// Timer value.
  final Duration value;

  /// Remaining, when timer is changing color.
  final Duration alertRemaining;

  /// Callback to be called when the timer is complete.
  final VoidCallback onTimerComplete;

  const RoundTimerView({
    super.key,
    required this.value,
    required this.alertRemaining,
    required this.onTimerComplete,
  });

  @override
  State<RoundTimerView> createState() => _RoundTimerViewState();
}

class _RoundTimerViewState extends State<RoundTimerView> {
  CountdownTimer? _timer;
  late Duration _duration;

  StreamSubscription<CountdownTimer>? _subscription;

  @override
  void initState() {
    super.initState();
    _duration = widget.value;
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
    final timer = _timer;
    final isRunning = timer != null;
    final isDone = !isRunning && duration == Duration.zero;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TimerControlButton(
          onPressed: _resetTimer,
          child: Text(loc.timerResetBtn),
        ),
        isRunning
            ? _RunningTimerValue(
                timer: timer,
                alertRemaining: alertRemaining,
              )
            : _TimerValue(
                duration: duration,
                alertRemaining: alertRemaining,
              ),
        isRunning
            ? _TimerControlButton(
                onPressed: _stopTimer,
                child: Text(loc.timerStopBtn),
              )
            : _TimerControlButton(
                onPressed: duration.inMilliseconds < 10 ? null : _startTimer,
                child: Text(loc.timerStartBtn),
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
        final timer = _timer = CountdownTimer(
          _duration,
          const Duration(seconds: 1),
        );
        _subscription = timer.listen(
          null,
          onDone: () {
            _stopTimer();
            widget.onTimerComplete();
          },
        );
      });
    }
  }

  void _stopTimer() {
    final timer = _timer;
    if (timer != null) {
      setState(() {
        _duration =
            timer.remaining > Duration.zero ? timer.remaining : Duration.zero;
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

  const _RunningTimerValue({
    required this.timer,
    required this.alertRemaining,
  });

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

        final data = snapshot.data;
        return data != null
            ? _TimerValue(
                duration: data.remaining,
                alertRemaining: widget.alertRemaining,
              )
            : const Text('--');
      },
    );
  }
}

class _TimerValue extends StatelessWidget {
  static const _alertColor = Colors.red;

  final Duration duration;
  final Duration alertRemaining;

  const _TimerValue({
    required this.duration,
    required this.alertRemaining,
  });

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
  final VoidCallback? onPressed;

  const _TimerControlButton({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge;
    return RawMaterialButton(
      textStyle: textStyle?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: onPressed != null ? null : Colors.grey.shade500,
      ),
      constraints: const BoxConstraints(minWidth: 150, minHeight: 150),
      shape: CircleBorder(
        side: BorderSide(
          color: onPressed != null
              ? Colors.lightGreenAccent.shade400
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
