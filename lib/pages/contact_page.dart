import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/contactfriends.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Contacts"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              StreamBuilder(
                builder: (context, snapshot) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data?.docs;
                        List users = [];
                        for (var i in data!) {
                          users.add(i);
                        }

                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: users.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ContactFriends(
                                index: index,
                                users: users,
                              );
                            },
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}
