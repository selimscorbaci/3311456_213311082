import 'package:flutter/material.dart' show ChangeNotifier;

class SearchLoad extends ChangeNotifier {
  //this provider needs to fix
  String? email;
  String? name;
  String? uid;
  void addemail(String email) {
    this.email = email;
    notifyListeners();
  }

  void addName(String name) {
    this.name = name;
    notifyListeners();
  }

  void adduid(String uid) {
    this.uid = uid;
    notifyListeners();
  }
}
