import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFFAFBFF),
    appBarTheme: AppBarTheme(
      color: Color(0xFFFAFBFF),
      elevation: 0.0,
      actionsIconTheme: IconThemeData(color: Color(0xFF151717), size: 24.0),
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Color(0xFF151717),
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF151717),
        size: 24.0,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.white38,
    ),
  );

  static final ThemeData darkTheme = lightTheme;
}
