import 'package:chat_app/providers/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_man.dart';
import '../widgets/userchat.dart';
import '../providers/chat_cont.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                  backgroundImage: Provider.of<Userinfo>(context)
                              .userAdded
                              .photourl !=
                          ""
                      ? NetworkImage(
                          "${Provider.of<Userinfo>(context).userAdded.photourl}")
                      : null),
            ),
            Consumer<Userinfo>(
              builder: (_, user, __) {
                return Column(
                  children: [
                    Text("${(user.userAdded.name)}"),
                    FutureBuilder(
                        future: FirestoreManagement()
                            .getUserDocId("${user.userAdded.uid}"),
                        builder: (context, snapshotfuture) {
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(snapshotfuture.data)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "${(snapshot.data?.data())?['status'] ?? ""}",
                                  style: TextStyle(fontSize: 14),
                                );
                              }
                              return Container();
                            },
                          );
                        })
                  ],
                );
              },
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FutureBuilder(
            future: FirestoreManagement().userInformation(
                Provider.of<Userinfo>(context).userAdded.uid ?? ""),
            builder: (_, snapshotFuture) {
              if (snapshotFuture.hasError) {
                return Center(
                  child:
                      Text("Something went wrong for loading the conversation"),
                );
              }

              final userinfo = snapshotFuture.data;

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .doc(userinfo?.elementAt(2))
                    .collection('messagelist')
                    .orderBy('addtime', descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasData) {
                    final data = snapshot.data?.docs;
                    List messagelist = [];
                    for (var i in data!) {
                      messagelist.add(i);
                    }

                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: messagelist.length,
                        itemBuilder: (_, index) {
                          return UserChat(
                            userInformation: userinfo,
                            index: index,
                            messagelist: messagelist,
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text("there is no message"),
                  );
                },
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 9, bottom: 8, top: 8),
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: Consumer<ChatProvider>(
                        builder: (_, chat, __) {
                          return TextField(
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text: (chat.input?.text).toString(),
                                selection: TextSelection(
                                  baseOffset:
                                      (chat.input?.text).toString().length,
                                  extentOffset:
                                      (chat.input?.text).toString().length,
                                ),
                              ),
                            ),
                            onChanged: (text) {
                              chat.addInput(text);
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Write your message",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none),
                          );
                        },
                      ),
                    ),
                    Consumer<Userinfo>(
                      builder: (_, user, __) {
                        return Consumer<ChatProvider>(
                          builder: (_, message, __) {
                            return GestureDetector(
                              onTap: () {
                                FirestoreManagement().haveChat(
                                    user.userAdded.uid.toString(),
                                    user.userAdded.name.toString(),
                                    (message.input?.text).toString());
                                message.Send();
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
