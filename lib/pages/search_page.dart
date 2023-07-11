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
                  child: TextField(
                    onChanged: (email) {
                      onSearch(context, email);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Enter an email"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                  child: Consumer<Userinfo>(
                    builder: (_, user, __) {
                      return ListTile(
                        onTap: () {
                          user.empty();
                          Navigator.of(context).pushNamed('/friendsPage');
                        },
                        trailing: Icon(Icons.list),
                        title: Text("Friends"),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                    child: (Provider.of<Userinfo>(context).userAdded.email !=
                            null)
                        ? Consumer<Userinfo>(
                            builder: (_, user, __) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: user.userAdded.photourl != ""
                                      ? NetworkImage(
                                          "${user.userAdded.photourl}")
                                      : null,
                                ),
                                title: Text(user.userAdded.name.toString()),
                                subtitle: Text(user.userAdded.email.toString()),
                                onTap: () {
                                  if (user.userAdded.uid != null) {
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
      Provider.of<Userinfo>(context, listen: false)
          .addPhoto(doc.get('photourl'));
    });
  });
}
