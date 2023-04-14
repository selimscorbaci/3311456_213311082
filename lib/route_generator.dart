import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/create_account_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/loginPage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/accountPage':
        return MaterialPageRoute(builder: (_) => AccountPage());
      case '/searchPage':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case '/chatPage':
        return MaterialPageRoute(builder: (_) => ChatPage());
      case '/settingsPage':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        break;
    }
  }
}
