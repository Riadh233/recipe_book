import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1
  static TextTheme lightTextTheme = TextTheme(
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.outfit(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.outfit(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,),
  );

  // 2
  static TextTheme darkTextTheme = TextTheme(
    bodySmall: GoogleFonts.outfit(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
  static ColorScheme colorSchemeLight = const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.amber,
      onPrimary: Colors.black,
      secondary: Colors.amberAccent,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black);

  static ColorScheme colorSchemeDark = const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.amber,
      onPrimary: Colors.white,
      secondary: Colors.amberAccent,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white);

  // 3
  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: colorSchemeLight,
    );
  }

  // 4
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme:colorSchemeDark
    );
  }
}