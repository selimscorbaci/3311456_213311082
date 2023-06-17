import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileKnowledge extends StatelessWidget {
  const ProfileKnowledge({
    super.key,
    required this.text,
    this.userName,
  });
  final String text;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$text ",
                style: TextStyle(fontSize: 16, color: Colors.purple),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Text(
                    "${userName ?? FirebaseAuth.instance.currentUser?.email}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 1,
          //       blurRadius: 1,
          //       offset: Offset(0, 0)),
          // ],
          ),
      width: MediaQuery.of(context).size.width,
    );
  }
}
