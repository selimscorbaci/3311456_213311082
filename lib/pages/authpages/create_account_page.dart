import 'package:chat_app/providers/user_info.dart';
import 'package:flutter/material.dart';
import '../../services/auth_man.dart';
import 'package:provider/provider.dart';
import '../../widgets/userform.dart';

// ignore: must_be_immutable
class AccountPage extends StatelessWidget {
  AuthManagement auth = AuthManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Create an Account to Continue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, top: 50),
                        child: Consumer<Userinfo>(
                          builder: (_, user, __) {
                            return UserForm(
                                user.addUsername,
                                false,
                                TextInputType.emailAddress,
                                "Name",
                                Icon(Icons.account_box),
                                25);
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, top: 8),
                        child: Consumer<Userinfo>(
                          builder: (_, user, __) {
                            return UserForm(
                                user.addUseremail,
                                false,
                                TextInputType.emailAddress,
                                "Email",
                                Icon(Icons.email));
                          },
                        ),
                      ),

                      //password
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<Userinfo>(
                          builder: (_, user, __) {
                            return UserForm(
                                user.addUserpassword,
                                true,
                                TextInputType.number,
                                "Password",
                                Icon(Icons.lock),
                                9);
                          },
                        ),
                      ),

                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 150,
                          height: 50,
                          child: Consumer<Userinfo>(
                            builder: (_, user, __) {
                              return TextButton(
                                onPressed: () {
                                  auth.createAccount(user.userAdded);
                                },
                                child: Center(
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "login",
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
