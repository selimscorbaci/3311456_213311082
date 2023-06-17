import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangePasswordForm extends StatelessWidget {
  ChangePasswordForm(
      this.labelText, this.icon, this.textEditingController, this.isobsecure,
      [this.maxlength = null]);

  String labelText;
  int? maxlength;
  Icon icon;
  bool isobsecure;
  TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: (textEditingController?.text).toString(),
          selection: TextSelection(
            baseOffset: (textEditingController?.text).toString().length,
            extentOffset: (textEditingController?.text).toString().length,
          ),
        ),
      ),
      obscureText: isobsecure,
      keyboardType: (labelText == "Email")
          ? TextInputType.emailAddress
          : TextInputType.number,
      maxLength: maxlength,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: icon,
        label: Text(
          "$labelText",
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
