import 'package:chat_app/providers/user_info.dart';
import 'package:chat_app/services/firestore_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserChat extends StatefulWidget {
  UserChat({this.userInformation, this.index, required this.messagelist});
  final index;
  final List messagelist;
  final List? userInformation;

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  bool ondoubletap = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: (widget.userInformation?.elementAt(0) ==
                  widget.messagelist[widget.index]['uid'])
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Row(
              children: [
                ondoubletap &&
                        (widget.userInformation?.elementAt(0) ==
                            widget.messagelist[widget.index]['uid'])
                    ? Consumer<Userinfo>(
                        builder: (_, user, __) {
                          return GestureDetector(
                              onTap: () async {
                                await FirestoreManagement()
                                    .deleteMessage(
                                        user.userAdded.uid.toString(),
                                        widget.messagelist[widget.index]
                                            ['contentid'])
                                    .whenComplete(() async {
                                  await FirestoreManagement().updateLastMessage(
                                      user.userAdded.uid.toString());
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.delete_outline_rounded));
                        },
                      )
                    : Container(),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      ondoubletap = !ondoubletap;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.80), //400 changed as MediaQuery.of(context).size.width * 0.80
                    decoration: BoxDecoration(
                      borderRadius: widget.userInformation?.elementAt(0) ==
                              widget.messagelist[widget.index]['uid']
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                      color: widget.userInformation?.elementAt(0) ==
                              widget.messagelist[widget.index]['uid']
                          ? Colors.purple
                          : Colors.grey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.messagelist[widget.index]['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          (widget.messagelist[widget.index]['addtime']
                                      as Timestamp)
                                  .toDate()
                                  .hour
                                  .toString() +
                              ":" +
                              ((widget.messagelist[widget.index]
                                                  ['addtime'] as Timestamp)
                                              .toDate()
                                              .minute <=
                                          9
                                      ? "0" +
                                          ((widget.messagelist[widget.index]
                                                      ['addtime'] as Timestamp)
                                                  .toDate()
                                                  .minute)
                                              .toString()
                                      : (widget.messagelist[widget.index]
                                              ['addtime'] as Timestamp)
                                          .toDate()
                                          .minute
                                          .toString())
                                  .toString(),
                          style: TextStyle(color: Colors.blueGrey[900]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
