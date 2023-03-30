import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fl_egypt_trust/data/local_data_source/theme/them_local_data.dart';
import 'package:fl_egypt_trust/models/entities/theme_enities/colors_entity.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../di/dependency_injection.dart';

class Palette{
  Palette(_);
 static getColorByKey(String key){
    return int.parse(sl<ThemeBloc>().colorsPalette.where((element) => element.key==key).first.val!);
  }

  static  Color mainGreen= Color(getColorByKey('mainGreen'));
  static  Color mainBlue= Color(getColorByKey('mainBlue'));
  static  Color white=Color(getColorByKey('white'));
  static  Color text = Color(getColorByKey('text'));
  static  Color textAlt = Color(getColorByKey('textAlt'));
  static  Color hint = Color(getColorByKey('hint'));
  static  Color disable = Color(getColorByKey('disable'));
  static Color  black10 = Color(getColorByKey('black10'));
  static  Color black15 = Color(getColorByKey('black15'));
  static  Color black20 = Color(getColorByKey('black20'));
  static  Color black25 = Color(getColorByKey('black25'));
  static  Color black = Color(getColorByKey('black'));
  static  Color colorRed = Color(getColorByKey('colorRed'));
  static  Color colorYellow = Color(getColorByKey('colorYellow'));
  static  Color textHint = Color(getColorByKey('textHint'));
  static  Color mainTitleText = Color(getColorByKey('mainTitleText'));
  static  Color whatsApp = Color(getColorByKey('whatsApp'));
  static  Color facebook = Color(getColorByKey('facebook'));
  static  Color twitter = Color(getColorByKey('twitter'));
  static  Color instagram = Color(getColorByKey('instagram'));


  // static renderAppIcons()async{
  //  final appIcons=sl<ThemeBloc>().appIcons;
  //  File imageFile = File('${appIcons[0].filepath}/${appIcons[0].imagename}${appIcons[0].exten}');
  //  await imageFile.writeAsBytes(response.bodyBytes);
  // }
}