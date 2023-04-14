import 'package:flutter/material.dart' show ChangeNotifier;

class PageIndexController extends ChangeNotifier {
  int index = 1;

  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}
