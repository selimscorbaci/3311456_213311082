import 'package:chat_app/services/firestore_man.dart';
import 'package:chat_app/services/storage_man.dart';
import 'package:chat_app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import '../widgets/profileknowledge.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String url = "";

  @override
  void initState() {
    super.initState();

    StorageManagement().takeUserPhotoUrl().then((value) {
      url = value;
    }).whenComplete(() {
      setState(() {});
    });
    FirestoreManagement().currUserName().then((value) {
      userName = value;
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color.fromRGBO(75, 75, 150, 1)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    try {
                      if (url != "") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ClipRRect(
                              child: Image.network(
                                url,
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
                        radius: MediaQuery.of(context).size.width * 0.30,
                        backgroundImage: (url != "") ? NetworkImage(url) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurpleAccent),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              await StorageManagement().loadFromCamera();
                            },
                            icon: Icon(Icons.add_a_photo_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ProfileKnowledge(userName: userName, text: "Name"),
              ProfileKnowledge(text: "About"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
