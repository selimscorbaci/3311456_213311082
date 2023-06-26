import 'package:chat_app/providers/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottomnav.dart';

class SearchPage extends StatelessWidget {
  // const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Consumer<Userinfo>(
                    builder: (_, email, __) {
                      return TextField(
                        onChanged: (value) {
                          onSearch(_, value);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Enter a email"),
                      );
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0, right: 8),
              //   child: Card(
              //     child: ListTile(
              //       trailing: Icon(Icons.arrow_drop_down_circle_rounded),
              //       title: Text("Friends"),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                    child: (Provider.of<Userinfo>(context)
                                .userAdded
                                .email
                                ?.isNotEmpty ??
                            false)
                        ? Consumer<Userinfo>(
                            builder: (_, user, __) {
                              return ListTile(
                                leading: CircleAvatar(),
                                title: Text(user.userAdded.name.toString()),
                                subtitle: Text(user.userAdded.email.toString()),
                                onTap: () {
                                  if (user.userAdded.uid != null) {
                                    user.addUseremail("");
                                    Navigator.of(context)
                                        .pushNamed('/chatPage');
                                  }
                                },
                                trailing: Icon(Icons.add),
                              );
                            },
                          )
                        : Container()),
              ),
              // StreamBuilder(
              //   stream: FirebaseFirestore.instance
              //       .collection('users')
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       final data = snapshot.data?.docs;
              //       List users = [];
              //       for (var i in data!) {
              //         users.add(i);
              //       }

              //       return Container(
              //         height: 200,
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: users.length,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return SearchPageFriends(
              //               index: index,
              //               users: users,
              //             );
              //           },
              //         ),
              //       );
              //     }
              //     return CircularProgressIndicator();
              //   },
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

Future<void> onSearch(BuildContext context, String email) async {
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Provider.of<Userinfo>(context, listen: false)
          .addUsername(doc.get('name'));
      Provider.of<Userinfo>(context, listen: false)
          .addUseremail(doc.get('email'));
      Provider.of<Userinfo>(context, listen: false)
          .addUserid(doc.get('id')); //sender id
    });
  });
}
