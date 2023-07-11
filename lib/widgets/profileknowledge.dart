import 'package:flutter/material.dart';

class ProfileKnowledge extends StatelessWidget {
  const ProfileKnowledge({
    super.key,
    required this.text,
    this.userName,
    this.description,
    this.ontap,
  });
  final String text;
  final String? description;
  final String? userName;
  final void Function()? ontap;

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
              child: SingleChildScrollView(
                child: userName != null
                    ? Text(
                        "${userName}",
                        style: TextStyle(fontSize: 16),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.80),
                            child: Text("$description"),
                          ),
                          GestureDetector(
                            onTap: ontap,
                            child: Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}
