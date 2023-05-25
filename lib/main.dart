import 'package:chat_app/pages/chat_page.dart' show ChatProvider;
import 'package:chat_app/providers/is_logged.dart';
import 'package:chat_app/providers/page_index_cont.dart';
import 'package:chat_app/providers/search_load.dart';
import 'package:chat_app/providers/user_info.dart';
import 'package:chat_app/config/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsLogged().createSharedPrefObj();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => IsLogged()),
    ChangeNotifierProvider(create: (_) => Userinfo()),
    ChangeNotifierProvider(create: (_) => SearchLoad()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => PageIndexController())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute:
          Provider.of<IsLogged>(context).islogged ? '/' : '/loginPage',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: HomePage(),
    );
  }
}
