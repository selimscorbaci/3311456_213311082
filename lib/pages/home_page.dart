import 'package:chat_app/providers/page_index_cont.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Provider.of<PageIndexController>(context).loadPage();
=======
    return (Provider.of<PageIndexController>(context).index != 1)
        ? ProfilePage()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(75, 75, 150, 1),
                title: Text(
                  "Messages",
                ),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "It seems there is no dialog with others, click search button and have a chat with your friends",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigation(),
            ),
          );
>>>>>>> 71ed54dd3ecb02ca19bdcdc20a6bdefcee3a0d06
  }
}
