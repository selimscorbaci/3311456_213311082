import 'package:flutter/material.dart';
import '../../services/auth_man.dart';

class ForgotPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 15, left: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Write your email below and we will send a link in your email",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      label: Text(
                        "Email",
                        style: TextStyle(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OutlinedButton(
                      onPressed: () async {
                        AuthManagement().verifyEmail(email.text);
                      },
                      child: Text(
                        "Send Link To email",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
