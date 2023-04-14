import 'package:chat_app/providers/search_load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text((Provider.of<SearchLoad>(context).name ?? "").toString()),
        elevation: 0,
      ),
      body: Stack(children: [
        Positioned(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.899999,
          bottom: 0,
          left: 0,
          child: Consumer<ChatProvider>(
            builder: (context, value, child) {
              return TextField(
                onChanged: (text) {
                  value.addInput(text);
                },
                decoration: InputDecoration(
                    hintText: "Write your message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            },
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            width: MediaQuery.of(context).size.width * 0.10,
            height: 50,
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.send_rounded),
            ))
      ]),
    );
  }
}

class ChatProvider extends ChangeNotifier {
  String? input;
  void addInput(String text) {
    input = text;
    notifyListeners();
  }
}
