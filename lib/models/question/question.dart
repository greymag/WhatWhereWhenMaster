import 'package:flutter/foundation.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

/// Question model.
@JsonSerializable()
class Question extends Mappable {
  /// Text of the question.
  final String text;

  /// Answer to the question.
  final String answer;

  /// Alternative answer.
  ///
  /// It's not main answer, but it's also correct
  /// and will be accepted.
  ///
  /// Optional.
  final String answerAlt;

  /// Some introduction text.
  ///
  /// Optional.
  final String intro;

  /// Additional comment.
  ///
  /// Optional.
  final String comment;

  const Question(
      {@required this.text,
      @required this.answer,
      this.answerAlt,
      this.intro,
      this.comment})
      : assert(text != null),
        assert(answer != null);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  String toString() {
    return 'Question(text: $text, answer: $answer, '
        'answerAlt: $answerAlt, intro: $intro, comment: $comment)';
  }
}
