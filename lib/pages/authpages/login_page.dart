import 'package:chat_app/services/auth_man.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/user_info.dart';
import '../../widgets/userform.dart';

class LoginPage extends StatelessWidget {
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
                width: MediaQuery.of(context).size.width * 0.80,
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
                          "Sign in to Continue",
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
                                user.toggleUseremail,
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
                                user.toggleUserpassword,
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
                            builder: (_, value, __) {
                              return TextButton(
                                onPressed: () {
                                  AuthManagement()
                                      .logIn(value.userAdded)
                                      .then((val) {
                                    if (val == true) {
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

                              /////
                            },
                          ),
                        ),
                      ),

                      //

                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/forgotpasswordPage');
                        },
                        child: Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),

                      GestureDetector(
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
