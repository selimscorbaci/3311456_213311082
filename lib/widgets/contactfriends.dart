import 'package:chat_app/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
          child: Consumer<Userinfo>(
            builder: (_, user, __) {
              return InkWell(
                onTap: () async {
                  user.addUsername(users[index]['name']);
                  user.addUserid(users[index]['id']);
                  user.addPhoto(users[index]['photourl']); //new
                  Navigator.of(context).pushNamed('/chatPage');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: (users[index]['photourl'] != "")
                              ? NetworkImage(users[index]['photourl'])
                              : null,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
