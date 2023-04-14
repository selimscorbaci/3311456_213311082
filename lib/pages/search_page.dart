import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_load.dart';

class SearchPage extends StatelessWidget {
  // const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Consumer<SearchLoad>(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                  child: (Provider.of<SearchLoad>(context).email?.isNotEmpty ??
                          false)
                      ? Consumer<SearchLoad>(
                          builder: (_, user, __) {
                            return ListTile(
                              leading:
                                  CircleAvatar(backgroundColor: Colors.red),
                              title: Text(user.name.toString()),
                              subtitle: Text(user.email.toString()),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/chatPage');
                              },
                              trailing: Icon(Icons.add),
                            );
                          },
                        )
                      : Container()),
            )
          ],
        ),
      ),
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
      Provider.of<SearchLoad>(context, listen: false).addName(doc.get('name'));
      Provider.of<SearchLoad>(context, listen: false)
          .addemail(doc.get('email'));
      Provider.of<SearchLoad>(context, listen: false)
          .adduid(doc.get('id')); //sender id
    });
  });
}
