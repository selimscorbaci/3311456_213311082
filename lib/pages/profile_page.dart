import 'package:chat_app/services/firestore_man.dart';
import 'package:chat_app/services/storage_man.dart';
import 'package:chat_app/widgets/bottomnav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color.fromRGBO(75, 75, 150, 1)),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () async {
                  String url = await StorageManagement().takeUserPhotoUrl();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: 200,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );

                  NetworkImage(await StorageManagement().takeUserPhotoUrl());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: CircleAvatar(),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await StorageManagement().loadFromCamera();
                },
                icon: Icon(Icons.add_a_photo)),
            Text(
              "Email: " + (FirebaseAuth.instance.currentUser?.email).toString(),
              style: GoogleFonts.lora(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
