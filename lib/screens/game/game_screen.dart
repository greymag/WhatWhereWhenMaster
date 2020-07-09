import 'package:flutter/material.dart';

import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/models/models.dart';
import 'package:WhatWhereWhenMaster/screens/game/round_timer_view.dart';
import 'package:WhatWhereWhenMaster/widgets/question/question_view.dart';
import 'package:list_ext/list_ext.dart';

/// Screen for game process.
///
/// Shows question and timer.
class GameScreen extends StatefulWidget {
  final Round round;

  const GameScreen({Key key, @required this.round})
      : assert(round != null),
        super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Question _currentQuestion;

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
    final isFirst = index == 0;
    final isLast = index == list.length - 1;
    return _GameScreenContent(
      question: question,
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

class _GameScreenContent extends StatefulWidget {
  final Question question;
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;

  const _GameScreenContent(
      {Key key,
      @required this.question,
      @required this.onPrevPressed,
      @required this.onNextPressed})
      : assert(question != null),
        super(key: key);

  @override
  _GameScreenContentState createState() => _GameScreenContentState();
}

class _GameScreenContentState extends State<_GameScreenContent> {
  bool _isShowAnswer = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          QuestionView(
            question: widget.question,
            showAnswer: _isShowAnswer,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: Text(loc.prevQuestionBtn),
                onPressed: widget.onPrevPressed,
              ),
              if (!_isShowAnswer)
                FlatButton(
                  child: Text(loc.showAnswerBtn),
                  onPressed: _showAnswer,
                ),
              FlatButton(
                child: Text(loc.nextQuestionBtn),
                onPressed: widget.onNextPressed,
              ),
            ],
          ),
          RoundTimerView(
            value: const Duration(minutes: 1),
            alertRemaining: const Duration(seconds: 10),
            onTimerComplete: _showAnswer,
          ),
        ],
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
