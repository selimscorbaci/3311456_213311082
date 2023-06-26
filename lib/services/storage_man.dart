import 'dart:io';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/firestore_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageManagement {
  File? _file;
  UserModel user = UserModel.fromJson({});
  Future<String> takeUserPhotoUrl([String toUid = ""]) async {
    try {
      user.uid = await FirestoreManagement().currUID();
      user.photourl = await FirebaseStorage.instance
          .ref()
          .child('profilepictures')
          .child((toUid == "") ? user.uid! : toUid)
          // .child("profilepicture")
          .getDownloadURL();
      return user.photourl ?? "";
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
        user.uid = await FirestoreManagement().currUID();
        final ref = await FirebaseStorage.instance
            .ref()
            .child('profilepictures')
            .child(user.uid!);
        // .child("profilepicture");

        ref.putFile(_file!);

        user.photourl = await ref.getDownloadURL();

        final userDocId = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId)
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .get();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDocId.docs.first.id)
            .update({"photourl": user.photourl});
      }
    } catch (_) {}
  }
}
