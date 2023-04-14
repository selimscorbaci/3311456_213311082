import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'model/users.dart' show Users;
import 'package:fluttertoast/fluttertoast.dart';

class AuthManagement {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

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
          "id": userc.getID,
          "name": userc.name,
          "email": userc.email,
          "password": userc.password
        });
      }
      _showMessageDesign("User created", Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _showMessageDesign("Email already in use", Colors.red);
      } else if (e.code == "weak-password") {
        _showMessageDesign("Weak password", Colors.red);
      }
    } catch (_) {
      _showMessageDesign("Something went wrong", Colors.grey);
    }
  }

//for signout
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      _showMessageDesign("something went wrong", Colors.grey);
    }
  }

//for login
  Future<bool?> logIn(Users userc) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userc.email, password: userc.password);
      _showMessageDesign("logged Succesfully", Colors.green);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessageDesign("User not found", Colors.red);
        return false;
      } else if (e.code == 'wrong-password') {
        _showMessageDesign("Wrong password", Colors.red);
        return false;
      }
    } catch (_) {
      _showMessageDesign("Something went wrong", Colors.grey);
      return false;
    }
  }

  void _showMessageDesign(String msg, Color color) {
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
