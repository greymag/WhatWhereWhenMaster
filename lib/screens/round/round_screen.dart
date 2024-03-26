import 'package:flutter/material.dart';
import 'package:innim_lib/innim_lib.dart';

import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/models/models.dart';
import 'package:what_where_when_master/widgets/question/question_view.dart';

import 'round_timer_view.dart';

/// Round of the game.
///
/// Screen for game process. Shows question and timer.
class RoundScreen extends StatefulWidget {
  final Round round;

  const RoundScreen({super.key, required this.round});

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  late Question _currentQuestion;

  @override
  void initState() {
    super.initState();

    _currentQuestion = widget.round.questions.first;
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.round.questions;
    final question = _currentQuestion;
    final index = list.indexOf(question);
    final number = index + 1;
    final total = list.length;
    final isFirst = index == 0;
    final isLast = number == total;
    return _RoundScreenContent(
      question: question,
      questionNum: number,
      totalQuestions: total,
      onPrevPressed: isFirst
          ? null
          : () {
              _changeQuestion(-1);
            },
      onNextPressed: isLast
          ? null
          : () {
              _changeQuestion(1);
            },
    );
  }

  void _changeQuestion(int shift) {
    final list = widget.round.questions;
    final current = list.indexOf(_currentQuestion);
    final question = list.tryElementAt(current + shift);

    if (question != null && question != _currentQuestion) {
      setState(() {
        _currentQuestion = question;
      });
    }
  }
}

class _RoundScreenContent extends StatefulWidget {
  final int questionNum;
  final int totalQuestions;
  final Question question;
  final VoidCallback? onPrevPressed;
  final VoidCallback? onNextPressed;

  const _RoundScreenContent({
    required this.question,
    required this.questionNum,
    required this.totalQuestions,
    required this.onPrevPressed,
    required this.onNextPressed,
  });

  @override
  _RoundScreenContentState createState() => _RoundScreenContentState();
}

class _RoundScreenContentState extends State<_RoundScreenContent> {
  bool _isShowAnswer = false;

  @override
  void didUpdateWidget(_RoundScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.question != widget.question) {
      _isShowAnswer = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final question = widget.question;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.getQuestionTitle(widget.questionNum, widget.totalQuestions),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QuestionView(
                question: question,
                showAnswer: _isShowAnswer,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ControlButton.wide(
                  label: loc.prevQuestionBtn,
                  onPressed: widget.onPrevPressed,
                ),
                if (!_isShowAnswer)
                  _ControlButton(
                    label: loc.showAnswerBtn,
                    onPressed: _showAnswer,
                  ),
                _ControlButton.wide(
                  label: loc.nextQuestionBtn,
                  onPressed: widget.onNextPressed,
                ),
              ],
            ),
            const Spacer(flex: 1),
            RoundTimerView(
              key: ValueKey(question),
              value: const Duration(minutes: 1),
              handInAnswers: const Duration(seconds: 10),
              alertRemaining: const Duration(seconds: 10),
              onTimerComplete: _showAnswer,
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  void _showAnswer() {
    if (!_isShowAnswer) {
      setState(() {
        _isShowAnswer = true;
      });
    }
  }
}

class _ControlButton extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const _ControlButton({
    required this.onPressed,
    required this.label,
    this.padding = const EdgeInsets.all(8.0),
  });

  factory _ControlButton.wide({
    required VoidCallback? onPressed,
    required String label,
  }) =>
      _ControlButton(
        onPressed: onPressed,
        label: label,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
