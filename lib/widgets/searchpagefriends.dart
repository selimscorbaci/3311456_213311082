import 'package:flutter/material.dart';

class SearchPageFriends extends StatelessWidget {
  SearchPageFriends({required this.index, required this.users});
  final index;
  final users;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
            ),
            Text(
              "${users[index]['name']}",
              // style: GoogleFonts.(fontSize: 18),
            ),
            Text(users[index]['email'])
          ],
        ),
      ),
    );
  }
}
