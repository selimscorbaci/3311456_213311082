import 'dart:io';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/firestore_man.dart';
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
          .getDownloadURL();
      return user.photourl ?? "";
    } catch (_) {
      return "";
    }
  }

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

        ref.putFile(_file!).then((p0) async {
          await ref.getDownloadURL().then((value) async {
            user.photourl = value;
            await FirestoreManagement().updateUserPhoto(user.photourl);
          });
        });
      }
    } catch (_) {}
  }
}
