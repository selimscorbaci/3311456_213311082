import 'package:chat_app/authentication.dart';
import 'package:chat_app/providers/is_logged.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/user_info.dart';

class LoginPage extends StatelessWidget {
  AuthManagement auth = AuthManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(width: 0.1),
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5)),
          width: 300,
          height: 300,
          child: Column(children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Text(
                  "Sign in to Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                      child: TextFormField(
                        onChanged: (useremail) {
                          Provider.of<Userinfo>(context, listen: false)
                              .toggleUseremail(useremail);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text(
                            "email",
                            style: TextStyle(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (userpassword) {
                          Provider.of<Userinfo>(context, listen: false)
                              .toggleUserpassword(userpassword);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          label: Text(
                            "password",
                            style: TextStyle(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 150,
                        height: 50,
                        child: Consumer<Userinfo>(
                          builder: (_, value, __) {
                            return Consumer<IsLogged>(
                              builder: (context, value2, child) {
                                return TextButton(
                                  onPressed: () {
                                    auth.logIn(value.userAdded).then((val) {
                                      if (val == true) {
                                        value2.setIsLogged(true);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/', (route) => false);
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/accountPage');
                      },
                      child: Text(
                        "or create a Account",
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
