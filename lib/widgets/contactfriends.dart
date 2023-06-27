import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactFriends extends StatelessWidget {
  ContactFriends({required this.index, required this.users});
  final index;
  final users;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${users[index]['name']}",
                    style: GoogleFonts.arimo(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
