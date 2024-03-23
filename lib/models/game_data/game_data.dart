import 'package:innim_lib/innim_lib.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:what_where_when_master/models/round/round.dart';

part 'game_data.g.dart';

/// Game data model.
@JsonSerializable()
class GameData extends Mappable {
  /// Rounds of the game.
  final List<Round> rounds;

  const GameData({required this.rounds});

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameDataToJson(this);

  @override
  String toString() => 'GameData(rounds: $rounds)';
}

/// Game data entry.
///
/// Model for a list of games, without full data
/// (rounds, questions, etc).
@JsonSerializable()
class GameDataEntry extends Mappable {
  /// Unique identifier.
  final String uid;

  /// Game title.
  final String title;

  const GameDataEntry({
    required this.uid,
    required this.title,
  });

  factory GameDataEntry.fromJson(Map<String, dynamic> json) =>
      _$GameDataEntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameDataEntryToJson(this);

  @override
  String toString() => 'GameDataEntry(uid: $uid, title: $title)';
}
