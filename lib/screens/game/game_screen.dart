import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/models/models.dart';
import 'package:WhatWhereWhenMaster/screens/game/round_timer_view.dart';
import 'package:WhatWhereWhenMaster/widgets/question/question_view.dart';
import 'package:flutter/material.dart';

/// Screen for game process.
///
/// Shows question and timer.
class GameScreen extends StatefulWidget {
  final Question question;

  const GameScreen({Key key, @required this.question})
      : assert(question != null),
        super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          QuestionView(
            question: widget.question,
            showAnswer: _showAnswer,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: Text(loc.prevQuestionBtn),
                onPressed: () {
                  // TODO: prev question
                },
              ),
              if (!_showAnswer)
                FlatButton(
                  child: Text(loc.showAnswerBtn),
                  onPressed: () {
                    setState(() {
                      _showAnswer = true;
                    });
                  },
                ),
              FlatButton(
                child: Text(loc.nextQuestionBtn),
                onPressed: () {
                  // TODO: next question
                },
              ),
            ],
          ),
          RoundTimerView(
            value: const Duration(minutes: 1),
            alertRemaining: const Duration(seconds: 10),
          ),
        ],
      ),
    );
  }
}
