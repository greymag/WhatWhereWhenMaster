// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) => Round(
      number: json['number'] as int,
      name: json['name'] as String?,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'questions': instance.questions,
    };
