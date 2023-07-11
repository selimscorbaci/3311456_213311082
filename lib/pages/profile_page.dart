import 'package:chat_app/services/firestore_man.dart';
import 'package:chat_app/services/storage_man.dart';
import 'package:chat_app/widgets/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/profileknowledge.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> editField(String field) async {
    String tmp = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit ${field.toLowerCase()}"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              tmp = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await FirestoreManagement().updateDescription(tmp);
                  Navigator.of(context).pop();
                },
                child: Text('Save'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color.fromRGBO(75, 75, 150, 1)),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
              future: FirestoreManagement().getUserDocId(),
              builder: (context, snapshotfuture) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(snapshotfuture.data)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data =
                            snapshot.data?.data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  try {
                                    if (data['photourl'] != "") {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ClipRRect(
                                            child: Image.network(
                                              data['photourl'],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } catch (_) {}
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.30,
                                      backgroundImage: (data['photourl'] != "")
                                          ? NetworkImage(data['photourl'])
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.deepPurpleAccent),
                                        child: IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            await StorageManagement()
                                                .loadFromCamera();
                                          },
                                          icon:
                                              Icon(Icons.add_a_photo_outlined),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ProfileKnowledge(
                              userName: data['name'],
                              text: "Name",
                              ontap: () => editField("Name"),
                            ),
                            ProfileKnowledge(
                              description: data['description'],
                              text: "Description",
                              ontap: () => editField("Description"),
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
