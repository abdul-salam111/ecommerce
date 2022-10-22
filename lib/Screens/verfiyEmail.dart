import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'HomeScreen.dart';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({Key? key}) : super(key: key);
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final firebase = FirebaseAuth.instance;
  User? user;
  Timer? timer;
  @override
  void initState() {
    user = firebase.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerification() async {
    user = firebase.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => HomeScreen()));
      Fluttertoast.showToast(msg: "Registered Successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(),
      opacity: 0.5,
      isLoading: true,
      child: Center(
        child: Text("Verify Your Email please"),
      ),
    ));
  }
}
