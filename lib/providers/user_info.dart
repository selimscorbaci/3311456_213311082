import 'package:flutter/material.dart' show ChangeNotifier;
import '../models/user_model.dart';

//for managing user information
class Userinfo extends ChangeNotifier {
  UserModel _user = UserModel.fromJson({});

  void addUsername(String username) {
    _user.name = username;
    notifyListeners();
  }

  void addUseremail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void addUserpassword(String password) {
    _user.password = password;
    notifyListeners();
  }

  void addUserid(String uid) {
    _user.uid = uid;
    notifyListeners();
  }

  void addPhoto(String photourl) {
    _user.photourl = photourl;
    notifyListeners();
  }

  UserModel get userAdded => _user;

  void empty() {
    _user = UserModel.fromJson({
      'uid': null,
      'name': null,
      'email': null,
      'password': null,
      'photourl': null,
    });
    notifyListeners();
  }
}
