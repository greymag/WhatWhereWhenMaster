import 'package:innim_lib/innim_lib.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:what_where_when_master/models/question/question.dart';

part 'round.g.dart';

/// Model for the round of a game.
@JsonSerializable()
class Round extends Mappable {
  /// Round number.
  ///
  /// Defines an order.
  final int number;

  /// Round name.
  ///
  /// Optional.
  /// If note defined, than [number] will be used for name,
  /// e.g. "Round 1".
  final String? name;

  /// List of questions.
  ///
  /// Sorted in an order of appearance.
  final List<Question> questions;

  const Round({
    required this.number,
    this.name,
    required this.questions,
  })  : assert(number >= 0, 'should be positive'),
        // ignore: prefer_is_empty
        assert(questions.length > 0, 'should be not empty');

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoundToJson(this);

  @override
  String toString() =>
      'Round(number: $number, name: $name, questions: $questions)';
}
