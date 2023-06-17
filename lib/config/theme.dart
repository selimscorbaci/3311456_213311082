import 'package:flutter/material.dart';

class ThemeModes {
  static ThemeData darkMode = ThemeData(
    // primaryColor: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
      ),
    ),
  );

  static ThemeData lightMode = ThemeData(
    // primaryColor: Colors.deepPurple,
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
      ),
    ),
  );
}
