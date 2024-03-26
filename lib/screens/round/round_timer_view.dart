import 'dart:async';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import 'package:what_where_when_master/application/localization.dart';

/// Timer for round view.
class RoundTimerView extends StatefulWidget {
  /// Timer value.
  final Duration value;

  /// Time for hand in the answers.
  final Duration handInAnswers;

  /// Remaining, when timer is changing color.
  final Duration alertRemaining;

  /// Callback to be called when the timer is complete.
  final VoidCallback onTimerComplete;

  const RoundTimerView({
    super.key,
    required this.value,
    required this.handInAnswers,
    required this.alertRemaining,
    required this.onTimerComplete,
  });

  @override
  State<RoundTimerView> createState() => _RoundTimerViewState();
}

class _RoundTimerViewState extends State<RoundTimerView> {
  CountdownTimer? _timer;
  late Duration _duration;

  var _stage = _TimerStage.notStarted;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TimerControlButton(
          onPressed: _resetTimer,
          child: Text(loc.timerResetBtn),
        ),
        isRunning
            ? _RunningTimerValue(
                key: ValueKey(_stage),
                timer: timer,
                alertRemaining: alertRemaining,
                label: switch (_stage) {
                  _TimerStage.round => loc.thinkingTime,
                  _TimerStage.handInAnswers => loc.handInAnswers,
                  _ => ''
                },
              )
            : _TimerValue(
                value: duration,
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
        _stage = _TimerStage.notStarted;
        _clearTimer();
        _duration = widget.value;
      });
    }
  }

  void _startTimer() {
    if (_timer == null) {
      setState(() {
        if (_stage == _TimerStage.notStarted) _stage = _TimerStage.round;

        final timer = _timer = CountdownTimer(
          _duration,
          const Duration(seconds: 1),
        );

        _subscription = timer.listen(
          null,
          onDone: () {
            _stopTimer();

            switch (_stage) {
              case _TimerStage.round:
                if (widget.handInAnswers > Duration.zero) {
                  _stage = _TimerStage.handInAnswers;
                  _duration = widget.handInAnswers;
                  _startTimer();
                } else {
                  _finishTimer();
                }
              case _TimerStage.handInAnswers:
                _finishTimer();
              case _TimerStage.notStarted:
              case _TimerStage.finished:
              // can't be
            }
          },
        );
      });
    }
  }

  void _finishTimer() {
    _stage = _TimerStage.finished;
    widget.onTimerComplete();
  }

  void _stopTimer() {
    final timer = _timer;
    if (timer != null) {
      setState(() {
        _duration = timer.normalizedRemaining;
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
  final String label;

  const _RunningTimerValue({
    super.key,
    required this.timer,
    required this.alertRemaining,
    required this.label,
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
            ? _buildValue(context, duration: data.normalizedRemaining)
            : const Text('--');
      },
    );
  }

  Widget _buildValue(
    BuildContext context, {
    required Duration duration,
  }) {
    return Stack(
      children: [
        const SizedBox(height: 10),
        _TimerValue(
          value: duration,
          alertRemaining: widget.alertRemaining,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: AnimateWidget(
              cycles: 0,
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              builder: (context, anim) => Opacity(
                opacity:
                    anim.fromTween((currentValue) => 1.0.tweenTo(0.0)) ?? 1,
                child: Text(widget.label),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerValue extends StatelessWidget {
  static const _alertColor = Colors.red;

  final Duration value;
  final Duration alertRemaining;

  const _TimerValue({
    required this.value,
    required this.alertRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAlert = value <= alertRemaining;
    final color = isAlert ? _alertColor : null;
    return Row(
      children: [
        for (final char in loc.getTimerValue(value).characters)
          _buildSlot(
            context,
            value: char,
            color: color,
          ),
      ],
    );
  }

  Widget _buildSlot(
    BuildContext context, {
    required String value,
    required Color? color,
  }) {
    final isSeparator = value == ':';
    final width = isSeparator ? 30.0 : 60.0;

    Widget child = Text(
      value,
      style: TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.w200,
        color: color,
      ),
      textAlign: TextAlign.center,
    );

    if (isSeparator) {
      child = Baseline(
        baseline: 86,
        baselineType: TextBaseline.ideographic,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 3),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: width,
      child: child,
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

enum _TimerStage { notStarted, round, handInAnswers, finished }

extension _CountdownTimerExtension on CountdownTimer {
  Duration get normalizedRemaining =>
      remaining > Duration.zero ? remaining : Duration.zero;
}
