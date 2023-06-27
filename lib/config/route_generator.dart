import 'package:chat_app/pages/authpages/passforgot_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/contact_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/authpages/create_account_page.dart';
import 'package:chat_app/pages/authpages/login_page.dart';
import 'package:chat_app/pages/statistics_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../pages/authpages/changep_page.dart';

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
      case '/profilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/changepPage':
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case '/forgotpasswordPage':
        return MaterialPageRoute(
          builder: (_) => ForgotPage(),
        );

      case '/statisticsPage':
        return MaterialPageRoute(
          builder: (_) => StatisticsPage(),
        );
      case '/friendsPage':
        return MaterialPageRoute(
          builder: (_) => ContactPage(),
        );
      default:
        break;
    }
    return null;
  }
}
