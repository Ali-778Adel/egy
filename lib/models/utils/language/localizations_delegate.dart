import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/bloc/settings_bloc/cubit_seetings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;


import 'language_ar.dart';
import 'language_en.dart';
import 'languages.dart';

Languages appLocalization = AppLocalizationsDelegate.instance();
class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  static const LocalizationsDelegate<Languages> delegate = AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        EnumLanguage.english.localeValue(),
        EnumLanguage.arabic.localeValue()
      ].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) {
    return _locale(locale);
  }

  static Future<Languages> _locale(Locale locale) async {
    switch (locale.languageCode.toLowerCase()) {
      case 'ar':
        return LanguageAr();
      default:
        return LanguageEn();
    }
  }

  static Languages instance() {
    String lang = BlocProvider.of<PrefSettingsModelCubit>(navigatorKey.currentContext!)
        .state
        .currentLocale
        ?.languageCode ?? EnumLanguage.arabic.localeValue();
    print(' app lang : $lang');
    switch (lang) {
      case 'ar':
        return LanguageAr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;

  static bool isDirectionRTL(BuildContext context) {
    return intl.Bidi.isRtlLanguage(
        Localizations.localeOf(context).languageCode);
  }


  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizationsDelegate.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Locale? localeResolutionCallback(Locale? locale, Iterable<Locale>? supportedLocales) {
    for (Locale supportedLocale in (supportedLocales ?? [])) {
      if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales?.first;
  }


}
