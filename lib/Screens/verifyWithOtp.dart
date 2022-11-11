import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utilities/constants.dart';
import 'HomeScreen.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  void dispose() {
    super.dispose();
    otpcontroller.dispose();
    phonecontroller.dispose();
  }

  final phonecontroller = TextEditingController(text: "+92");
  final otpcontroller = TextEditingController();

  Widget phone() {
    return SizedBox(
      height: 70,
      child: TextFormField(
          controller: phonecontroller,
          maxLength: 13,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            label: Text("Phone"),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: maincolor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                )),
            prefixIcon: Icon(
              Icons.email,
              color: maincolor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(color: maincolor, width: 2)),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              border:
                  Border.all(color: const Color.fromARGB(255, 18, 147, 164))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: MediaQuery.of(context).size.width / 4,
            backgroundImage: const AssetImage('images/logo.png'),
          ),
        ),
      ),
      SizedBox(
        height: screenSize.height / 10,
      ),
      Form(
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(children: [
                phone(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: maincolor,
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                      verifyOTP(phonecontroller.text.trim());
                    },
                    child: reSendCode
                        ? const Text("Resend Code")
                        : const Text("Send Code")),
              ])))
    ]));
  }

  bool reSendCode = false;
  String verificationIDRecieved = "";
  final firebase = FirebaseAuth.instance;
  void verifyOTP(String phone) {
    try {
      firebase.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebase.signInWithCredential(credential).then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const HomeScreen()));
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            Fluttertoast.showToast(
                msg: exception.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER);
          },
          codeSent: (verificationId, forceResendingToken) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Enter Your Code"),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      controller: otpcontroller,
                      maxLength: 6,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: maincolor),
                              onPressed: () async {
                                try {
                                  await firebase
                                      .signInWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId:
                                                  verificationIDRecieved,
                                              smsCode: otpcontroller.text))
                                      .then((value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const HomeScreen()));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: e.message!,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP);
                                }
                              },
                              child: const Text("Verify Code")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: maincolor),
                              onPressed: () async {
                                setState(() {
                                  reSendCode = true;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        ],
                      ),
                    ],
                  );
                });
            setState(() {
              verificationIDRecieved = verificationId;
            });
          },
          codeAutoRetrievalTimeout: ((verificationId) {
            setState(() {
              verificationIDRecieved = verificationId;
            });
          }),
          timeout: const Duration(minutes: 2));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
