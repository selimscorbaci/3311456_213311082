import 'package:chat_app/providers/search_load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatsScrolling extends StatelessWidget {
  ChatsScrolling({
    this.index,
    required this.users,
    required this.userInformation,
  });
  final index;
  final List users; //includes from_id, to_id, from_name,to_name
  final List? userInformation; //current user information(name,id,docid...)

  String url = "";

  @override
  Widget build(BuildContext context) {
    url = (users[index]['to_photourl'] == userInformation?.elementAt(2)
            ? users[index]['from_photourl']
            : users[index]['to_photourl'])
        .toString();
    return Consumer<SearchLoad>(
      builder: (_, friend, __) {
        return GestureDetector(
          onTap: () async {
            friend.addName(
                userInformation?.elementAt(1) == users[index]['to_name']
                    ? users[index]['from_name']
                    : users[index]['to_name']);

            friend.adduid(
                (users[index]["to_uid"] == userInformation?.elementAt(0))
                    ? users[index]["from_uid"]
                    : users[index]["to_uid"]);
            Navigator.of(context).pushNamed('/chatPage');
          },
          child: Card(
            elevation: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: (url != "") ? NetworkImage(url) : null,
                    child: GestureDetector(
                      onTap: () {
                        if (url != "") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: 200,
                                height: 200,
                                child: ClipRRect(
                                  child: Image.network(
                                    '${url}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                (users[index]["to_name"] == userInformation?.elementAt(1))
                    ? Text(users[index]["from_name"])
                    : Text(users[index]["to_name"]),
              ],
            ),
          ),
        );
      },
    );
  }
}
