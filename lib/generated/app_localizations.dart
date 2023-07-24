import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppLocalizations {
  String get signup;
  String? translate(String key);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final String? jsonContent = await rootBundle.loadString('assets/locale/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonContent!);
    return SynchronousFuture<AppLocalizations>(AppLocalizationsImpl(jsonMap));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLocalizationsImpl implements AppLocalizations {
  final Map<String, dynamic> _localizedStrings;

  AppLocalizationsImpl(this._localizedStrings);

  @override
  String get signup {
    return _localizedStrings['signup'] ?? '';
  }

  @override
  String? translate(String key) {
    return _localizedStrings[key];
  }
}