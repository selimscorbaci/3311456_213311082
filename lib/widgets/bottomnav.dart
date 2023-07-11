import 'package:chat_app/providers/page_index_cont.dart';
import 'package:chat_app/providers/theme_cont.dart';
import 'package:chat_app/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  List light = [Colors.grey, Colors.deepPurple, Colors.white];
  List dark = [Colors.white, Colors.deepPurple, Colors.grey];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManagement>(
      builder: (_, theme, __) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1.0))),
          child: Consumer<PageIndexController>(
            builder: (_, value, __) {
              return GNav(
                  selectedIndex: value.index,
                  activeColor: (theme.getMode) ? dark[1] : light[1],
                  backgroundColor: (theme.getMode) ? dark[2] : light[2],
                  color: (theme.getMode) ? dark[0] : light[0],
                  gap: 3,
                  tabs: [
                    GButton(
                      icon: Icons.account_circle,
                      text: "Profile",
                      onPressed: () {
                        value.changeIndex(0);
                      },
                    ),
                    GButton(
                      icon: Icons.chat_bubble,
                      text: "Chat",
                      onPressed: () {
                        value.changeIndex(1);
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      text: "Search",
                      onPressed: () {
                        value.changeIndex(2);
                        Provider.of<Userinfo>(context, listen: false).empty();
                      },
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: "Settings",
                      onPressed: () {
                        value.changeIndex(3);
                      },
                    ),
                  ]);
            },
          ),
        );
      },
    );
  }
}
