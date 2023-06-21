import 'package:chat_app/services/storage_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreManagement {
  String _userID = "";
  String _userName = "";
  String _docIdController = "";
  String _photourl = "";
  //this method returns current user ID
  Future<String> currUID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _userID = doc["id"];
      });
    });
    return _userID;
  }

  Future<String> currUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        _userName = doc['name'];
      });
    });
    return _userName;
  }

  Future<String> docIDController(String toUid) async {
    _userID = await currUID();
    String result = "";
    await FirebaseFirestore.instance
        .collection('messages')
        .where(FieldPath.documentId, isEqualTo: (toUid + _userID))
        .get()
        .then((snapshots) {
      if (snapshots.docs.isEmpty) {
        result = (_userID + toUid); //docid doc1doc2
      } else {
        result = (toUid + _userID); //docid doc2doc1
      }
    });
    return result;
  }

  Future<List> userInformation([String touid = ""]) async {
    _userID = await currUID();
    _userName = await currUserName();
    _docIdController = await docIDController(touid);

    if (touid == "") {
      await StorageManagement().takeUserPhotoUrl().then((value) {
        _photourl = value;
      });
      return [_userID, _userName, _photourl];
    } else {
      return [_userID, _userName, _docIdController];
    }
  }

  //touid is your friends id
  Future<void> haveChat(String? toUid, String toName, String? content) async {
    if (toUid != null && content != null) {
      _userID = await currUID();
      _userName = await currUserName();
      _docIdController = await docIDController(toUid);
      await StorageManagement().takeUserPhotoUrl().then((value) {
        _photourl = value;
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
        'from_uid': _userID,
        'from_name': _userName,
        'to_uid': toUid,
        'to_name': toName,
        'from_photourl': _photourl,
        'to_photourl': friendurl

        // 'from_photourl': _photourl,
        // 'to_photourl': friendphotourl
      }); //doc has a id

      await FirebaseFirestore.instance
          .collection('messages')
          .doc(
              _docIdController) //same doc id everytime we are adding a new document with the same chat id
          .collection('messagelist')
          .add({
        'addtime': DateTime.now(),
        'content': content,
        'uid': _userID
      }); //we storage the data with current user id and his/her friend's id
    }
  }

  Future<void> addUser(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      "id": Uuid().v1() + DateTime.now().millisecondsSinceEpoch.toString(),
      "name": name,
      "email": email,
      "photourl": ""
    });
  }

  //returns the current user message properties such as content,addtime,uid
  Future<List> getAllCurrentUserMessageProperties() async {
    List tmp = [];
    List data = [];
    String userid = await FirestoreManagement().currUID();

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
      if (tmp[i]['uid'] == userid) {
        data.add(tmp[i]);
      }
    }

    return data;
  }
}
