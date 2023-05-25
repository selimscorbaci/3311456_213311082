import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:shared_preferences/shared_preferences.dart';

class IsLogged with ChangeNotifier {
  bool islogged = true; //change it as false
  static SharedPreferences? _sharedpref;
  void setIsLogged(bool value) {
    islogged = value;
    _saveLogged(islogged);
    notifyListeners();
  }

  Future<void> createSharedPrefObj() async {
    _sharedpref = await SharedPreferences.getInstance();
  }

  void _saveLogged(bool val) {
    _sharedpref?.setBool("booleanvalue23321", val);
  }
}
