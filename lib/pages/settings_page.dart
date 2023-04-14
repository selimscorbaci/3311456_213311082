import 'package:chat_app/authentication.dart';
import 'package:chat_app/providers/is_logged.dart';
import 'package:chat_app/providers/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Color.fromRGBO(75, 75, 150, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 25, bottom: 10),
        child: Row(
          children: [
            Text(
              "Sign out",
              style: GoogleFonts.signika(fontSize: 20),
            ),
            Consumer<Userinfo>(
              builder: (_, user, __) {
                return Consumer<IsLogged>(
                  builder: (_, islog, __) {
                    return IconButton(
                      onPressed: () {
                        AuthManagement auth = AuthManagement();
                        auth.signOut();
                        islog.setIsLogged(false);
                        user.toggleUseremail("");
                        user.toggleUsername("");
                        user.toggleUserpassword("");
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/loginPage', (route) => false);
                      },
                      icon: Icon(Icons.output),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
