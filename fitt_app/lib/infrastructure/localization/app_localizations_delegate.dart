import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    _appLocalizationsCompleter = Completer<bool>();

    final localeStr = await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    final localeMap = jsonDecode(localeStr) as Map<String, dynamic>;

    final Map<String, String> newLocaleMap = {};

    _mergeLocaleMaps(localeMap, '', newLocaleMap);

    final AppLocalizations appLocalizations = AppLocalizations(locale: locale, localeMap: newLocaleMap);

    GetIt.instance.registerSingleton<AppLocalizations>(appLocalizations);

    _appLocalizationsCompleter.complete(true);

    return appLocalizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

void _mergeLocaleMaps(Map<String, dynamic> partOfLocaleMap, String baseKey, Map<String, String> newLocaleMap) {
  for (final entry in partOfLocaleMap.entries) {
    final String key;
    if (baseKey.isNotEmpty) {
      key = '$baseKey.${entry.key}';
    } else {
      key = entry.key;
    }
    if (entry.value is String) {
      newLocaleMap[key] = entry.value.toString();
    } else {
      _mergeLocaleMaps(entry.value as Map<String, dynamic>, key, newLocaleMap);
    }
  }
}

Completer<bool> _appLocalizationsCompleter = Completer();