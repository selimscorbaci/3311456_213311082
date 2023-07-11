import 'package:chat_app/services/firestore_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/bottomnav.dart';
import '../widgets/chatsscroll.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 75, 150, 1),
        title: Text(
          "Messages",
        ),
        elevation: 0,
      ),
      // backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: FirestoreManagement().userInformation(),
              builder: (context, snapshotFuture) {
                final userInformation = snapshotFuture.data;
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .orderBy('addtime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.docs;
                      List users = [];
                      for (var i in data!) {
                        if (i['from_uid'] == userInformation?.elementAt(0) ||
                            i['to_uid'] == userInformation?.elementAt(0)) {
                          users.add(i);
                        }
                      }

                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ChatsScrolling(
                                index: index,
                                users: users,
                                userInformation: userInformation);
                          },
                        ),
                      );
                    }

                    return CircularProgressIndicator();
                  },
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
