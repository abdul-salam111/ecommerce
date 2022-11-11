import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasework/AdminPanel/adminhomescreen.dart';
import 'package:firebasework/Screens/navigation_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Screens/HomeScreen.dart';
import '../Screens/WelcomeScreen.dart';

class AuthServices {
  handleState() {
    try {
      return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("something went wrong"),
              );
            } else if (snapshot.hasData) {
              return const NavigationBars();
            } else {
              return const WelcomeScreen();
            }
          });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
  

  googleSignOut(context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Fluttertoast.showToast(msg: "SignOut", toastLength: Toast.LENGTH_LONG)
            .then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (builder) => const WelcomeScreen()));
        });
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }
}
