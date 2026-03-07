import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color mintGreen = Color(0xFF7FFCAA);
  static const Color softCyan = Color(0xFF92DEFF);
  static const Color lightBlue = Color(0xFFA4E7F9);
  static const Color softBlue = Color(0xFF0087FF);
  static const Color limeYellow = Color(0xFFEAED2A);
  static const Color lavender = Color(0xFF5F33E1);
  static const Color lavenderLight = Color(0xFF8764FF);
  static const Color lightGray = Color(0xFF6E6A7C);
  static const Color softOrange = Color(0xFFFF7D53);
  static const Color softPink = Color(0xFFF478B8);

  static const Color cardCyan = Color(0xFFE7F3FF);
  static const Color cardOrange = Color(0xFFFFE9E1);
  static const Color cardLavender = Color(0xFFAB94FF);

  static const Color iconBgPink = Color(0xFFFFE4F2);
  static const Color iconBgLavender = Color(0xFFEDE4FF);
  static const Color iconBgOrange = Color(0xFFFFE6D4);

  // General ThemeData
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    hintColor: softCyan,
    scaffoldBackgroundColor: primaryColor,
    fontFamily: 'LexendDeca',
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: mintGreen,
        fontFamily: 'LexendDeca',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'LexendDeca',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
        fontFamily: 'LexendDeca',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: softCyan,
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'LexendDeca',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  // Reusable text styles
  static TextStyle headingStyle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: 'LexendDeca',
  );
  static TextStyle sectionTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: softCyan,
    fontFamily: 'LexendDeca',
  );
  static TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey[800],
    fontStyle: FontStyle.normal,
    fontFamily: 'LexendDeca',
  );
  static TextStyle subTextStyle = TextStyle(
    fontSize: 11,
    color: lightGray,
    fontStyle: FontStyle.italic,
    fontFamily: 'LexendDeca',
  );
}