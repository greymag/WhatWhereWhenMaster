import 'package:flutter/foundation.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:WhatWhereWhenMaster/models/round/round.dart';

part 'game_data.g.dart';

/// Game data model.
@JsonSerializable()
class GameData extends Mappable {
  /// Rounds of the game.
  final List<Round> rounds;

  const GameData({@required this.rounds}) : assert(rounds != null);

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameDataToJson(this);

  @override
  String toString() => 'GameData(rounds: $rounds)';
}
