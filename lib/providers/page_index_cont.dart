import 'package:chat_app/pages/chats_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart' show ChangeNotifier, Widget;

class PageIndexController extends ChangeNotifier {
  int index = 1;

  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  Widget loadPage() {
    switch (index) {
      case 0:
        return ProfilePage();
      case 1:
        return ChatsPage();
      case 2:
        return SearchPage();
      case 3:
        return SettingsPage();
      default:
        return HomePage();
    }
  }
}
