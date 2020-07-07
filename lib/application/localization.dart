import 'package:WhatWhereWhenMaster/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization/multiple_localization.dart';
import 'package:numerus/numerus.dart';

import 'l10n/messages_all.dart';

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLangs.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages, locale, (l) => AppLocalizations(l),
        setDefaultLocale: true);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

/// Application localization
class AppLocalizations {
  static const supportedLangs = ['ru'];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final supportedLocales = supportedLangs.map((lang) => Locale(lang));

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String locale;

  AppLocalizations(this.locale) : assert(locale != null);

  String get gameTitle => Intl.message('Выберите раунд', name: "gameTitle");

  String get bottomNavigationTabGame =>
      Intl.message('Игра', name: "bottomNavigationTabGame");

  String get bottomNavigationTabNotes =>
      Intl.message('Заметки', name: "bottomNavigationTabNotes");

  String get bottomNavigationTabRules =>
      Intl.message('Правила', name: "bottomNavigationTabRules");

  String get answerTitle => Intl.message('Ответ', name: "answerTitle");

  String getAlternativeAnswer(String value) => Intl.message(
        '($value)',
        name: "getAlternativeAnswer",
        args: [value],
      );

  String getCommentText(String comment) => Intl.message(
        'Комментарий: $comment',
        name: "getCommentText",
        args: [comment],
      );

  String getRoundTitle(Round round, int totalCounts) {
    if (round.name?.isNotEmpty ?? false) return round.name;

    if (round.number == 0)
      return warmUpRoundTitle;
    else if (round.number == totalCounts - 1)
      // TODO: remove this, should require name or separate bool for such round
      return reserveRoundTitle;
    else
      return getRoundNumberTitle(round.number.toRomanNumeralString());
  }

  String get warmUpRoundTitle =>
      Intl.message('Разминка', name: "warmUpRoundTitle");

  String get reserveRoundTitle =>
      Intl.message('Резерв', name: "reserveRoundTitle");

  String getRoundNumberTitle(String romanNumber) => Intl.message(
        'Раунд $romanNumber',
        name: "getRoundNumberTitle",
        args: [romanNumber],
      );

  String get prevQuestionBtn => Intl.message('Назад', name: "prevQuestionBtn");

  String get nextQuestionBtn => Intl.message('Далее', name: "nextQuestionBtn");

  String get showAnswerBtn =>
      Intl.message('Показать ответ', name: "showAnserBtn");

  String get timerResetBtn => Intl.message('Сбросить', name: "timerResetBtn");

  String get timerStartBtn => Intl.message('Старт', name: "timerStartBtn");

  String get timerStopBtn => Intl.message('Стоп', name: "timerStopBtn");

  String getTimerValue(Duration duration) {
    final seconds = (duration.inMilliseconds / 1000.0).round();
    return getTimeStr(
      _zeroPad2(duration.inMinutes),
      _zeroPad2(seconds % 60),
    );
  }

  String getTimeStr(String mm, String ss) => Intl.message(
        '$mm:$ss',
        name: "getTimeStr",
        args: [mm, ss],
      );

  String _zeroPad2(int val) => val.toString().padLeft(2, '0');
}
