import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserForm extends StatelessWidget {
  UserForm(final userinfo, bool isobsecure, TextInputType textInputType,
      String labeltext, Icon icon,
      [maxlength = null])
      : this.isobsecure = isobsecure,
        this.textInputType = textInputType,
        this.userinfo = userinfo,
        this.maxlength = maxlength,
        this.labeltext = labeltext,
        this.icon = icon;
  String labeltext;
  int? maxlength;
  bool isobsecure = false;
  final userinfo;
  TextInputType textInputType;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isobsecure,
      onChanged: userinfo,
      // keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      keyboardType: textInputType,
      maxLength: maxlength,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: Colors.white70, //Colors.white70
        prefixIcon: icon,
        prefixIconColor: Colors.blueGrey,
        label: Text(
          "$labeltext",
          style: TextStyle(color: Colors.grey),
        ),
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
