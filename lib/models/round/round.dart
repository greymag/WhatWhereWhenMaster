import 'package:flutter/foundation.dart';
import 'package:innim_lib/innim_lib.dart';

import 'package:WhatWhereWhenMaster/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'round.g.dart';

/// Model for the round of a game.
@JsonSerializable()
class Round extends Mappable {
  /// Round number.
  ///
  /// Defines an order.
  final int number;

  /// Round name.
  final String name;

  /// List of questions.
  final List<Question> questions;

  const Round(
      {@required this.number, @required this.name, @required this.questions})
      : assert(number != null && number >= 0),
        assert(name != null && name.length > 0),
        assert(questions != null && questions.length > 0);

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoundToJson(this);

  @override
  String toString() =>
      'Round(number: $number, name: $name, questions: $questions)';
}
