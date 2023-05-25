import 'package:flutter/material.dart';

class UserChat extends StatelessWidget {
  UserChat({this.userInformation, this.index, required this.messagelist});
  final index;
  final List messagelist;
  final List? userInformation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (userInformation?.elementAt(0) == messagelist[index]['uid'])
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: 400),
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
            color: userInformation?.elementAt(0) == messagelist[index]['uid']
                ? Colors.purple
                : Colors.grey,
          ),
          child: SelectableText(
            messagelist[index]['content'],
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
