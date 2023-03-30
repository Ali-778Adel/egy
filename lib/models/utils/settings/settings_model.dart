import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:flutter/material.dart';


class PrefSettingsModel {
  Locale? currentLocale;

  ThemeMode currentThemeMode = ThemeMode.light;


  PrefSettingsModel({this.currentLocale , this.currentThemeMode = ThemeMode.light});

  bool get isDarkMode => currentThemeMode == ThemeMode.dark;

}
