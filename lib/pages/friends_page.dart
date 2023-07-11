import 'package:chat_app/widgets/contactfriends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Friends"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              builder: (context, snapshot) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.docs;
                      List users = [];
                      for (var i in data!) {
                        users.add(i);
                      }

                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: users.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ContactFriends(
                              index: index,
                              users: users,
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
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
