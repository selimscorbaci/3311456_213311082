import 'dart:io';
import 'package:chat_app/services/firestore_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageManagement {
  String _userID = "";
  File? _file;
  String _url = "";

  Future<String> takeUserPhotoUrl([String toUid = ""]) async {
    try {
      _userID = await FirestoreManagement().currUID();
      _url = await FirebaseStorage.instance
          .ref()
          .child('profilepictures')
          .child((toUid == "") ? _userID : toUid)
          // .child("profilepicture")
          .getDownloadURL();
      return _url;
    } catch (_) {
      return "";
    }
  }

  //this is only for android and ios(this function does not work on web)
  Future<void> loadFromCamera() async {
    try {
      var pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        _file = File(pickedImage.path);
        _userID = await FirestoreManagement().currUID();
        final ref = await FirebaseStorage.instance
            .ref()
            .child('profilepictures')
            .child(_userID);
        // .child("profilepicture");

        ref.putFile(_file!);

        _url = await ref.getDownloadURL();

        final userDocId = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId)
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .get();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDocId.docs.first.id)
            .update({"photourl": _url});
      }
    } catch (_) {}
  }
}
