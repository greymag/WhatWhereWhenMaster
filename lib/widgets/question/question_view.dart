import 'package:WhatWhereWhenMaster/application/localization.dart';
import 'package:WhatWhereWhenMaster/models/question/question.dart';
import 'package:flutter/material.dart';

/// Widget for display question
class QuestionView extends StatelessWidget {
  static const _answerPadding = 40.0;

  final Question question;
  final bool showAnswer;

  const QuestionView(
      {Key key, @required this.question, @required this.showAnswer})
      : assert(question != null),
        assert(showAnswer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (question.hasIntro) _buildIntro(context, question),
        _buildQuestionText(context, question),
        const SizedBox(height: _answerPadding),
        if (showAnswer) _buildAnswer(context, question),
      ],
    );
  }

  Widget _buildIntro(BuildContext context, Question question) {
    return Text(question.intro);
  }

  Widget _buildQuestionText(BuildContext context, Question question) {
    return Text(question.text);
  }

  Widget _buildAnswer(BuildContext context, Question question) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(loc.answerTitle),
        Text(question.answer),
        if (question.hasAlternativeAnswer)
          Text(loc.getAlternativeAnswer(question.answerAlt)),
        if (question.hasComment) Text(loc.getCommentText(question.comment)),
      ],
    );
  }
}
