import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/HomeScreen.dart';

class SigningInUser {
  FirebaseAuth firebase = FirebaseAuth.instance;
  void userSigin(String email, String password, context) async {
    try {
      await firebase
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Fluttertoast.showToast(msg: "Loggedin Successfully!");
      }).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP);
    }
  }
}
