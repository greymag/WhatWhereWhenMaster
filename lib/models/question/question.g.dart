// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      text: json['text'] as String,
      answer: json['answer'] as String,
      answerAlt: json['answerAlt'] as String?,
      intro: json['intro'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'answer': instance.answer,
      'answerAlt': instance.answerAlt,
      'intro': instance.intro,
      'comment': instance.comment,
    };
