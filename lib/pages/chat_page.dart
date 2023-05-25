import 'package:chat_app/providers/search_load.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_man.dart';
import '../widgets/userchat.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text((Provider.of<SearchLoad>(context).name).toString()),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FutureBuilder(
            future: FirestoreManagement()
                .userInformation(Provider.of<SearchLoad>(context).uid ?? ""),
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
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
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
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Consumer<SearchLoad>(
                        builder: (_, user, __) {
                          return Consumer<ChatProvider>(
                            builder: (_, message, __) {
                              return GestureDetector(
                                onTap: () {
                                  FirestoreManagement().haveChat(
                                      user.uid.toString(),
                                      user.name.toString(),
                                      (message.input?.text).toString());
                                  message.isTouched();
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
                    )
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

class ChatProvider extends ChangeNotifier {
  TextEditingController? input = TextEditingController();
  bool isSended = false;
  void addInput(String text) {
    input?.text = text;
    notifyListeners();
  }

  void isTouched() {
    (input?.text != "") ? isSended = true : isSended = false;
    if (isSended) {
      input?.clear();
    }
    notifyListeners();
  }
}
