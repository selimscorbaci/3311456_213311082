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
                          "Create Account to Continue",
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
                                user.toggleUsername,
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
                          "login page",
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































// Center(
//         child: Container(
//           decoration: BoxDecoration(
//               // border: Border.all(width: 0.1),
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(5)),
//           width: 300,
//           height: 300,
//           child: Column(children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.only(top: 10, right: 10, left: 10),
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   "Create Account to \nContinue",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(right: 8, left: 8, bottom: 8),
//                       child: TextFormField(
//                         onChanged: (username) {
//                           Provider.of<Userinfo>(context, listen: false)
//                               .toggleUsername(username);
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.account_box),
//                           label: Text(
//                             "name",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(right: 8, left: 8, bottom: 8),
//                       child: TextFormField(
//                         onChanged: (useremail) {
//                           Provider.of<Userinfo>(context, listen: false)
//                               .toggleUseremail(useremail);
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email),
//                           label: Text(
//                             "email",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(right: 8, left: 8, bottom: 8),
//                       child: TextFormField(
//                         obscureText: true,
//                         maxLength: 9,
//                         onChanged: (userpassword) {
//                           Provider.of<Userinfo>(context, listen: false)
//                               .toggleUserpassword(userpassword);
//                         },
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           counterText: "",
//                           prefixIcon: Icon(Icons.lock),
//                           label: Text(
//                             "password",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.blueGrey,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         width: 150,
//                         height: 50,
//                         child: Consumer<Userinfo>(
//                           builder: (_, user, __) {
//                             return TextButton(
//                               onPressed: () {
//                                 auth.createAccount(user.userAdded);
//                               },
//                               child: Center(
//                                 child: Text(
//                                   "Create Account",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(
//                         "login",
//                         style: TextStyle(
//                             color: Colors.red,
//                             decoration: TextDecoration.underline),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ]),
//         ),
//       ),