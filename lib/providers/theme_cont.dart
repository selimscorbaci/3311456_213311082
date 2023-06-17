import 'package:chat_app/config/theme.dart';
import 'package:flutter/material.dart' show ChangeNotifier, ThemeData;
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManagement extends ChangeNotifier {
  bool isdark = false;
  static SharedPreferences? _sharedPreferences;

  Future<void> createSharedPrefObj() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  ThemeData get themeColor =>
      getMode ? ThemeModes.darkMode : ThemeModes.lightMode;

  Future<void> changeTheme() async {
    isdark = !isdark;
    _saveTheme(isdark);
    notifyListeners();
  }

  Future<void> _saveTheme(bool isdark) async {
    _sharedPreferences?.setBool("ThemeDataValue", isdark);
  }

  bool get getMode => _sharedPreferences?.getBool("ThemeDataValue") ?? false;
}
