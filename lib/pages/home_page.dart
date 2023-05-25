import 'package:chat_app/providers/page_index_cont.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<PageIndexController>(context).loadPage();
  }
}
