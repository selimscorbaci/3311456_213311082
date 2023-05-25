import 'package:chat_app/providers/page_index_cont.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 1.0))),
      child: Consumer<PageIndexController>(
        builder: (_, value, __) {
          return GNav(
              selectedIndex: value.index,
              activeColor: Colors.deepPurple,
              color: Colors.grey,
              backgroundColor: Colors.white,
              gap: 8,
              tabs: [
                GButton(
                  iconColor: Colors.grey,
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
  }
}
