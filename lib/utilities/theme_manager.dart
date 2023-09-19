import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_path.dart';

class ThemeManager {
  static ThemeManager sharedInstance = ThemeManager();

  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: ColorPath.appBarLight,
      foregroundColor: ColorPath.appBarDark,
    ),
    primaryColor: ColorPath.primaryTextLight,
    cardColor: ColorPath.primaryCardLight,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorPath.scaffoldLight,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.redHatDisplay(
        color: ColorPath.primaryTextLight,
        fontSize: 28,
      ),
      bodyMedium: GoogleFonts.redHatDisplay(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: GoogleFonts.redHatDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.redHatDisplay(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: ColorPath.appBarDark,
        foregroundColor: ColorPath.appBarLight
    ),
    primaryColor: ColorPath.primaryTextDark,
    brightness: Brightness.dark,
    cardColor: ColorPath.primaryCardDark,
    scaffoldBackgroundColor: ColorPath.scaffoldDark,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.redHatDisplay(
        color: ColorPath.primaryTextDark,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.redHatDisplay(
        color: ColorPath.secondaryTextDark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: GoogleFonts.redHatDisplay(
        color: ColorPath.primaryTextDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.redHatDisplay(
        color: ColorPath.primaryTextDark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

enum AppTheme{
  LIGHT, DARK, SYSTEM;

  static String rawValue(theme) {
    switch (theme) {
      case LIGHT:{return 'LIGHT';}
      case DARK:{return 'DARK';}
      case SYSTEM:{return 'SYSTEM';}
      default: {return 'SYSTEM';}
    }
  }
}