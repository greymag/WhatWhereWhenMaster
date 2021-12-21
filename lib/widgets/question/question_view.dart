import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/models/question/question.dart';
import 'package:flutter/material.dart';

/// Widget for display question
class QuestionView extends StatelessWidget {
  static const _answerPadding = 40.0;
  static const _mainTextStyle = TextStyle(fontSize: 24);

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        question.intro,
        style: _mainTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildQuestionText(BuildContext context, Question question) {
    return Text(
      question.text,
      style: _mainTextStyle,
    );
  }

  Widget _buildAnswer(BuildContext context, Question question) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Text(
          loc.answerTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          question.answer,
          style: _mainTextStyle,
        ),
        if (question.hasAlternativeAnswer)
          Text(
            loc.getAlternativeAnswer(question.answerAlt),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        if (question.hasComment)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              loc.getCommentText(question.comment),
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
