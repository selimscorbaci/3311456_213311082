import 'package:chat_app/providers/page_index_cont.dart';
import 'package:chat_app/providers/theme_cont.dart';
import 'package:chat_app/services/auth_man.dart';
import 'package:chat_app/providers/user_info.dart';
import 'package:chat_app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop();
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Color.fromRGBO(75, 75, 150, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Consumer<ThemeManagement>(
                builder: (_, theme, __) {
                  return ListTile(
                    trailing: (theme.getMode == false)
                        ? Icon(
                            Icons.dark_mode,
                            size: 36,
                          )
                        : Icon(
                            Icons.light_mode,
                            size: 36,
                          ),
                    title: Text(
                      (theme.getMode == false) ? "Dark Mode" : "Light Mode",
                      style: GoogleFonts.signika(fontSize: 18),
                    ),
                    onTap: () {
                      theme.changeTheme();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Lottie.asset(
                            controller: controller,
                            repeat: false,
                            onLoaded: (p0) {
                              controller.duration = p0.duration;
                              controller.forward();
                            },
                            'assets/animations/dark_light.json',
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Change Password",
                  style: GoogleFonts.signika(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/changepPage');
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Your statistics",
                  style: GoogleFonts.signika(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/statisticsPage');
                },
              ),
            ),
            Center(
              child: Consumer<Userinfo>(
                builder: (_, user, __) {
                  return OutlinedButton(
                    onPressed: () {
                      AuthManagement().signOut();
                      user.addUseremail("");
                      user.addUsername("");
                      user.addUserpassword("");
                      Provider.of<PageIndexController>(context, listen: false)
                          .changeIndex(1);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/loginPage', (route) => false);
                    },
                    child: Text(
                      "Sign Out ",
                      style: GoogleFonts.signika(
                          fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
