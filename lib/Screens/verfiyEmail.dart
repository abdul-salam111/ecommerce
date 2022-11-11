import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:loading_overlay/loading_overlay.dart';

import 'HomeScreen.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
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
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  Future<void> checkEmailVerification() async {
    user = firebase.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      checkEmailVerification().whenComplete(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const HomeScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          body: LoadingOverlay(
        color: Colors.grey,
        progressIndicator: const CircularProgressIndicator(),
        opacity: 0.5,
        isLoading: true,
        child: const Center(
          child: Text("Verify Your Email please"),
        ),
      )),
    );
  }
}
