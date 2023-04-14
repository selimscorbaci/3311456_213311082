import 'package:flutter/material.dart';
import 'dart:math' show Random;

class Users {
  String _id = Random().nextDouble().toString() +
      DateTime.now().toString() +
      DateTime.now().microsecond.toString() +
      "&%+^'^'!'^@";
  String name = "";
  String email = "";
  String password = "";

  Users({@required name, @required email, @required password});
  String get getID => _id;
}
