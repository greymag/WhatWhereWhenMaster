import 'package:flutter/material.dart';
import 'package:list_ext/list_ext.dart';

import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/models/models.dart';
import 'package:WhatWhereWhenMaster/widgets/question/question_view.dart';

import 'round_timer_view.dart';

/// Round of the game.
///
/// Screen for game process. Shows question and timer.
class RoundScreen extends StatefulWidget {
  final Round round;

  const RoundScreen({Key key, @required this.round})
      : assert(round != null),
        super(key: key);

  @override
  _RoundScreenState createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
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
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;

  const _RoundScreenContent(
      {Key key,
      @required this.question,
      @required this.questionNum,
      @required this.totalQuestions,
      @required this.onPrevPressed,
      @required this.onNextPressed})
      : assert(question != null),
        assert(questionNum != null),
        assert(totalQuestions != null),
        super(key: key);

  @override
  _RoundScreenContentState createState() => _RoundScreenContentState();
}

class _RoundScreenContentState extends State<_RoundScreenContent> {
  bool _isShowAnswer = false;

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
            QuestionView(
              question: question,
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
