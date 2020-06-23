import 'package:flutter/material.dart';
import 'package:multiple_localization/multiple_localization.dart';

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
}
