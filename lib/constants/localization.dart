// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_field, unused_local_variable, dead_code, unused_element, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetLocalization {
  final Locale local;

  SetLocalization(this.local);

  static SetLocalization? of(BuildContext context) {
    return Localizations.of<SetLocalization>(context, SetLocalization);
  }

  static const LocalizationsDelegate<SetLocalization> localizationsDelegate =
  _GetLocalizationDelegate();

  Map<String, String>? _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${local.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslateValue(String key) {
    return _localizedValues![key]!;
  }
}

class _GetLocalizationDelegate extends LocalizationsDelegate<SetLocalization> {
  const _GetLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<SetLocalization> load(Locale locale) async {
    SetLocalization localization = SetLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<SetLocalization> old) {
    return false;
  }
}
