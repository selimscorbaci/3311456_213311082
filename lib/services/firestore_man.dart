import 'package:chat_app/services/storage_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

class FirestoreManagement {
  String _docIdController = "";
  UserModel user = UserModel.fromJson({});

  //this method returns current user ID
  Future<String> currUID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user.uid = doc["id"];
      });
    });
    return user.uid ?? "";
  }

  Future<String> currUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        user.name = doc['name'];
      });
    });
    return user.name ?? "";
  }

  Future<String> docIDController(String toUid) async {
    user.uid = await currUID();
    String result = "";
    await FirebaseFirestore.instance
        .collection('messages')
        .where(FieldPath.documentId, isEqualTo: (toUid + user.uid!))
        .get()
        .then((snapshots) {
      if (snapshots.docs.isEmpty) {
        result = (user.uid! + toUid); //docid doc1doc2
      } else {
        result = (toUid + user.uid!); //docid doc2doc1
      }
    });
    return result;
  }

  Future<List> userInformation([String touid = ""]) async {
    user.uid = await currUID();
    user.name = await currUserName();
    _docIdController = await docIDController(touid);

    if (touid == "") {
      await StorageManagement().takeUserPhotoUrl().then((value) {
        user.photourl = value;
      });
      return [user.uid, user.name, user.photourl];
    } else {
      return [user.uid, user.name, _docIdController];
    }
  }

  //touid is your friends id
  Future<void> haveChat(String? toUid, String toName, String? content) async {
    if (toUid != null && content != null) {
      user.uid = await currUID();
      user.name = await currUserName();
      _docIdController = await docIDController(toUid);
      await StorageManagement().takeUserPhotoUrl().then((value) {
        user.photourl = value;
      });
      String friendurl = "";
      await StorageManagement().takeUserPhotoUrl(toUid).then((value) {
        if (value != "") {
          friendurl = value;
        }
      });
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(_docIdController)
          .set({
        'from_uid': user.uid,
        'from_name': user.name,
        'to_uid': toUid,
        'to_name': toName,
        'from_photourl': user.photourl,
        'to_photourl': friendurl
      }); //doc has a id

      await FirebaseFirestore.instance
          .collection('messages')
          .doc(
              _docIdController) //same doc id everytime we are adding a new document with the same chat id
          .collection('messagelist')
          .add({
        'addtime': DateTime.now(),
        'content': content,
        'uid': user.uid
      }); //we storage the data with current user id and his/her friend's id
    }
  }

  Future<void> addUser(UserModel user1) async {
    await FirebaseFirestore.instance.collection('users').add({
      "id": Uuid().v1() + DateTime.now().millisecondsSinceEpoch.toString(),
      "name": user1.name,
      "email": user1.email,
      "photourl": ""
    });
  }

  //returns the current user message properties such as content,addtime,uid
  Future<List> getAllCurrentUserMessageProperties() async {
    List tmp = [];
    List data = [];
    user.uid = await FirestoreManagement().currUID();

    QuerySnapshot mainCollectionRef =
        await FirebaseFirestore.instance.collection('messages').get();
    for (QueryDocumentSnapshot maindoc in mainCollectionRef.docs) {
      QuerySnapshot subcollectionDocs =
          await maindoc.reference.collection('messagelist').get();
      for (QueryDocumentSnapshot subDoc in subcollectionDocs.docs) {
        tmp.add(subDoc.data());
      }
    }
    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i]['uid'] == user.uid) {
        data.add(tmp[i]);
      }
    }

    return data;
  }
}
