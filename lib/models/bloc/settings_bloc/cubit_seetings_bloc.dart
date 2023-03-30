
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:fl_egypt_trust/models/utils/settings/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrefSettingsModelCubit extends Cubit<PrefSettingsModel> {
  PrefSettingsModelCubit(PrefSettingsModel initialState)
      : super(initialState);



  applyTheme({bool isOn = false}) async{
    await AppPreference.instance.setTheme(isOn ?ThemeMode.dark :ThemeMode.light);
    emit(PrefSettingsModel(currentLocale :state.currentLocale,currentThemeMode: isOn ?ThemeMode.dark :ThemeMode.light));
  }

  applyLocale(EnumLanguage language, {bool notify = true}) {
    AppPreference.instance.setLocale(language);

    if(notify){

      emit(PrefSettingsModel(currentLocale : Locale(language.localeValue()),currentThemeMode :state.currentThemeMode));
      appLocalization = AppLocalizationsDelegate.instance();
    }

  }

  toggleLocale() async{
    EnumLanguage lang = await AppPreference.instance.getLocale();
    EnumLanguage newLng = (lang == EnumLanguage.arabic ? EnumLanguage.english : EnumLanguage.arabic);
    AppPreference.instance.setLocale(newLng);
    emit(PrefSettingsModel(currentLocale : Locale(newLng.localeValue()),currentThemeMode : state.currentThemeMode));
    appLocalization = AppLocalizationsDelegate.instance();
  }

  getCurrentLocale({bool notify = true}) async {
    EnumLanguage lang = await AppPreference.instance.getLocale();
    return Locale(lang.localeValue());
  }
}
