import 'package:flutter/material.dart';

class Locales {
  static const String hu = 'hu';
  static const String en = 'en';
}

const languageCodesWithCountriesMap = <String, String>{
  'hu': 'hu-HU',
  'en': 'en-US',
};

class AppLocalizations {
  static const supportedLocales = [Locales.hu, Locales.en];
  final Locale locale;
  final Map<String, String> localeMap;

  AppLocalizations({required this.locale, required this.localeMap});

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(locale: const Locale(Locales.hu), localeMap: languageCodesWithCountriesMap);
  }

  String resolve(String key, [List<String>? parameters]) {
    if (!localeMap.containsKey(key)) {
      // ignore: avoid_print
      print('!!!!!! Not found $key in json!!!!!!');
      return key;
    }
    if (parameters != null) {
      String valueStr = localeMap[key]!;
      for (var i = 0; i < parameters.length; i++) {
        final param = parameters[i];
        valueStr = valueStr.replaceFirst('{$i}', param);
      }
      return valueStr;
    }
    return localeMap[key]!;
  }
}
