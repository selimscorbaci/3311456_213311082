import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserChat extends StatelessWidget {
  UserChat({this.userInformation, this.index, required this.messagelist});
  final index;
  final List messagelist;
  final List? userInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              (userInformation?.elementAt(0) == messagelist[index]['uid'])
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(10),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      0.80), //400 changed as MediaQuery.of(context).size.width * 0.80
              decoration: BoxDecoration(
                borderRadius:
                    userInformation?.elementAt(0) == messagelist[index]['uid']
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                color:
                    userInformation?.elementAt(0) == messagelist[index]['uid']
                        ? Colors.purple
                        : Colors.grey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    messagelist[index]['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    (messagelist[index]['addtime'] as Timestamp)
                            .toDate()
                            .hour
                            .toString() +
                        ":" +
                        ((messagelist[index]['addtime'] as Timestamp)
                                        .toDate()
                                        .minute <=
                                    9
                                ? "0" +
                                    ((messagelist[index]['addtime']
                                                as Timestamp)
                                            .toDate()
                                            .minute)
                                        .toString()
                                : (messagelist[index]['addtime'] as Timestamp)
                                    .toDate()
                                    .minute
                                    .toString())
                            .toString(),
                    style: TextStyle(color: Colors.blueGrey[900]),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
