import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_info.dart';

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
    return Consumer<Userinfo>(
      builder: (_, friend, __) {
        return GestureDetector(
          onTap: () async {
            friend.addUsername(
                userInformation?.elementAt(1) == users[index]['to_name']
                    ? users[index]['from_name']
                    : users[index]['to_name']);

            friend.addUserid(
                (users[index]["to_uid"] == userInformation?.elementAt(0))
                    ? users[index]["from_uid"]
                    : users[index]["to_uid"]);
            friend.addPhoto(
                (users[index]["to_photourl"] == userInformation?.elementAt(2))
                    ? users[index]["from_photourl"]
                    : users[index]["to_photourl"]);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: (users[index]["to_name"] ==
                              userInformation?.elementAt(1))
                          ? Text(users[index]["from_name"])
                          : Text(users[index]["to_name"]),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75),
                      child: Text(
                        "${users[index]["last_message"]}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
