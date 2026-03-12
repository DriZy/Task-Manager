import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette

  static const Color themeWhite = Color(0xFFFFFFFF);
  static const Color themeBlack = Color(0xFF24252C);
  static const Color themeGray = Color(0xFF6E6A7C);
  static const Color themeLavender = Color(0xFF5F33E1);
  static const Color themeSoftBlue = Color(0xFF0087FF);
  static const Color themeSoftPink = Color(0xFFF478B8);
  static const Color themeSoftOrange = Color(0xFFFF7D53);
  static const Color themeSoftLavender = Color(0xFF9260F4);
  static const Color themeLimeYellow = Color(0xFFEAED2A);
  static const Color themeLightBlue = Color(0xFFE7F3FF);
  static const Color themeLightOrange = Color(0xFFFFE9E1);
  static const Color themeLightLavender = Color(0xFF8764FF);

  static const Color themeIconBgPink = Color(0xFFFFE4F2);
  static const Color themeIconBgLavender = Color(0xFFEDE4FF);
  static const Color themeIconBgOrange = Color(0xFFFFE6D4);

  static const String _fontFamily = 'LexendDeca';

  static TextStyle lexendDecaStyle({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
    );
  }

  // General ThemeData
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFFFFFFF),
    hintColor: themeLightBlue,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: _fontFamily,
    textTheme: TextTheme(
      displayLarge: lexendDecaStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: themeGray,
      ),
      bodyLarge: lexendDecaStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: themeBlack,
      ),
      bodyMedium: lexendDecaStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: themeGray,
      ),
      labelLarge: lexendDecaStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: themeWhite,
      ),
      labelSmall: lexendDecaStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: themeGray,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: themeBlack,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: themeWhite,
        backgroundColor: themeLightBlue,
        textStyle: lexendDecaStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  // Reusable text styles
  static TextStyle onboardingTitle = lexendDecaStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: themeBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle onboardingText = lexendDecaStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: themeGray,
    fontStyle: FontStyle.normal,
  );

  static TextStyle cardTitle = lexendDecaStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: themeBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle buttonText = lexendDecaStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: themeBlack,
    // fontStyle: FontStyle.semiBold,
  );

  static TextStyle appBarTitle = lexendDecaStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: themeBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle appBarSubTitle = lexendDecaStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: themeGray,
    fontStyle: FontStyle.normal,
  );

  static TextStyle sectionTitle = lexendDecaStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: themeBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle bodyStyle = lexendDecaStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
    fontStyle: FontStyle.normal,
  );

  static TextStyle subTextStyle = lexendDecaStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: themeGray,
    fontStyle: FontStyle.italic,
  );
}