// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import '../model/users.dart';

//for managing user information
class Userinfo extends ChangeNotifier {
  final Users _user = Users();

  void toggleUsername(String username) {
    _user.name = username;
    notifyListeners();
  }

  void toggleUseremail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void toggleUserpassword(String password) {
    _user.password = password;
    notifyListeners();
  }

  Users get userAdded => _user;
}
