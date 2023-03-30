import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkBlackTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.grey.shade800,
  textTheme: GoogleFonts.ptSansCaptionTextTheme().apply(bodyColor: Colors.white),
);
