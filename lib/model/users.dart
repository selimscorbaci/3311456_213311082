import 'package:flutter/material.dart';

class Users {
  // String _id = Uuid().v1() + DateTime.now().millisecondsSinceEpoch.toString();
  String name = "";
  String email = "";
  String password = "";

  Users({@required name, @required email, @required password});
}
