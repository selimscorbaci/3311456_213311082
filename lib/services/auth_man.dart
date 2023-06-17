import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/users.dart' show Users;
import 'package:fluttertoast/fluttertoast.dart';

class AuthManagement {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> createAccount(Users userc) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userc.email,
        password: userc.password,
      );

      if (userc.name.isNotEmpty &&
          userc.email.isNotEmpty &&
          userc.password.isNotEmpty) {
        _firestore.add({
          "id": Uuid().v1() + DateTime.now().millisecondsSinceEpoch.toString(),
          "name": userc.name,
          "email": userc.email,
        });
      }

      _showMessage("User created", Colors.green);
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
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      _showMessage("something went wrong", Colors.grey);
    }
  }

//for login
  Future<bool?> logIn(Users userc) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userc.email, password: userc.password);
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
  Future<void> verifyEmail(String email) async {
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
        _showMessage('Passwords do not match', Colors.blueGrey);
        throw "";
      }
      _showMessage("Password changed", Colors.grey);
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        _showMessage("Weak Password, password's length has to more than 5",
            Colors.blueGrey);
      }
    } catch (_) {}
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
