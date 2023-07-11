import 'package:chat_app/providers/page_index_cont.dart';
import 'package:chat_app/services/firestore_man.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      FirestoreManagement().updateStatus("online");
    } else {
      FirestoreManagement().updateStatus("offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<PageIndexController>(context).loadPage();
  }
}
