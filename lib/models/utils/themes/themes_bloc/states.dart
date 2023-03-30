
import 'package:flutter/material.dart';

import '../../../entities/home_entities/home_translator_entity.dart';
import '../../../entities/theme_enities/colors_entity.dart';
import '../../../entities/theme_enities/icons_entity.dart';

enum ThemeResponseStatus{init,loading,error,success}
class ThemeStates{
  final String?message;
  final ThemeResponseStatus?themeResponseStatus;
  final List<ColorsEntity>?colorsEntity;
  final List<IconsEntity>?iconsEntity;
  final List<IconsEntity>?appSliderImages;
  final List<PublicTranslatorEntity>?generalTranslatorsEntity;
  final String ?appLocal;

  ThemeStates({this.appLocal,this.appSliderImages,this.generalTranslatorsEntity,this.themeResponseStatus=ThemeResponseStatus.init,this.message,this.iconsEntity,this.colorsEntity});
  ThemeStates.copyWith({this.appLocal,this.appSliderImages,this.generalTranslatorsEntity,this.themeResponseStatus,this.message,this.iconsEntity,this.colorsEntity});

}