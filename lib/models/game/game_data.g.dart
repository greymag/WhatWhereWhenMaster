// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameData _$GameDataFromJson(Map<String, dynamic> json) {
  return GameData(
    rounds: (json['rounds'] as List)
        ?.map(
            (e) => e == null ? null : Round.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameDataToJson(GameData instance) => <String, dynamic>{
      'rounds': instance.rounds,
    };
