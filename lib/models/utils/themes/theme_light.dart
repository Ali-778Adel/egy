import 'package:fl_egypt_trust/models/utils/themes/ui_constants.dart';
import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: UiConstants.colorPrimary),
    textTheme:const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Tajawal',
        height: 2.0,
        fontWeight: FontWeight.normal,
        color: Colors.black      ),
      bodyLarge: TextStyle(
          fontFamily: 'Tajawal',
        fontWeight: FontWeight.w600,
          fontSize: 18,
        height: 2.0,
        color: Colors.black,
      )
    )
    // GoogleFonts.ptSansCaptionTextTheme()

);
