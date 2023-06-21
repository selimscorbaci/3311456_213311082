import 'package:chat_app/services/auth_man.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final newpassword = TextEditingController();
  final confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        // elevation: 0,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                initialValue: FirebaseAuth.instance.currentUser?.email,
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: newpassword,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  decoration: InputDecoration(
                    counterText: "",
                    prefixIcon: Icon(Icons.lock),
                    label: Text(
                      "New Password",
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
                child: TextFormField(
                  controller: confirmpassword,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  decoration: InputDecoration(
                    counterText: "",
                    prefixIcon: Icon(Icons.lock),
                    label: Text(
                      "Confirm New Password",
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
                    AuthManagement()
                        .changePassword(
                            newpassword.text, (confirmpassword.text).toString())
                        .whenComplete(() {
                      setState(() {
                        confirmpassword.clear();
                        newpassword.clear();
                      });
                    });
                  },
                  child: Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
