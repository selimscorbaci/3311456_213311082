import 'package:chat_app/services/firestore_man.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart' show UserModel;
import 'package:fluttertoast/fluttertoast.dart';

class AuthManagement {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> createAccount(UserModel userc) async {
    try {
      if (userc.name != "" && userc.email != "" && userc.password != "") {
        await _auth.createUserWithEmailAndPassword(
          email: userc.email!,
          password: userc.password!,
        );

        await FirestoreManagement().addUser(userc);
      }

      _showMessage("User created", Colors.blueGrey);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _showMessage("Email already in use", Colors.blueGrey);
      } else if (e.code == "weak-password") {
        _showMessage("Weak password", Colors.blueGrey);
      }
    } catch (_) {
      _showMessage("Something went wrong", Colors.grey);
    }
  }

//for signout
  Future<void> signOut() async {
    try {
      await FirestoreManagement()
          .updateStatus("offline")
          .whenComplete(() async {
        await FirebaseAuth.instance.signOut();
      });
    } catch (e) {
      _showMessage("something went wrong", Colors.grey);
    }
  }

//for login
  Future<bool?> logIn(UserModel userc) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: userc.email!, password: userc.password!)
          .whenComplete(() async {
        await FirestoreManagement().updateStatus("online");
      });
      _showMessage("logged Succesfully", Colors.blueGrey);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessage("User not found", Colors.blueGrey);
        return false;
      } else if (e.code == 'wrong-password') {
        _showMessage("Wrong password", Colors.blueGrey);
        return false;
      }
    } catch (_) {
      _showMessage("Something went wrong", Colors.grey);
      return false;
    }
    return null;
  }

  //for changing user password with reset link
  Future<void> sendpasswordresetEmail(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      _showMessage("Sent", Colors.blueGrey);
    } catch (_) {
      _showMessage("Something went wrong", Colors.grey);
    }
  }

  Future<void> changePassword(
      String newPassword, String passwordconfirm) async {
    try {
      if (newPassword != passwordconfirm) {
        throw "Passwords do not match";
      }
      if (passwordconfirm.length < 6 && newPassword.length < 6) {
        throw "Weak Password, password's length has to more than 5";
      }
      _showMessage("Password changed", Colors.grey);
      await _auth.currentUser?.updatePassword(newPassword);
    } catch (err) {
      _showMessage("$err", Colors.blueGrey);
    }
  }

  void _showMessage(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
