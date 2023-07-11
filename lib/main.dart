import 'package:chat_app/pages/authpages/login_page.dart';
import 'package:chat_app/providers/chat_cont.dart';
import 'package:chat_app/providers/theme_cont.dart';
import 'package:chat_app/services/auth_man.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/providers/page_index_cont.dart';
import 'package:chat_app/providers/user_info.dart';
import 'package:chat_app/config/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ThemeManagement().createSharedPrefObj();
  runApp(MultiProvider(providers: [
    Provider<AuthManagement>(
      create: (_) => AuthManagement(),
    ),
    StreamProvider(
        create: (context) => context.read<AuthManagement>().authStateChanges,
        initialData: null),
    ChangeNotifierProvider(create: (_) => ThemeManagement()),
    ChangeNotifierProvider(create: (_) => Userinfo()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => PageIndexController())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chatapp',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeManagement>(context).themeColor,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: (context.watch<User?>() != null) ? HomePage() : LoginPage(),
    );
  }
}
