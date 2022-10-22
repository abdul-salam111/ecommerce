import 'package:ecommerce/Screens/HomeScreen.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpcontroller.dispose();
    phonecontroller.dispose();
  }

  final phonecontroller = TextEditingController(text: "+92");
  final otpcontroller = TextEditingController();

  Widget phone() {
    return Container(
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: maincolor,
                        minimumSize: Size(double.infinity, 50)),
                    onPressed: () {
                      verifyOTP(phonecontroller.text.trim());
                      print("done");
                    },
                    child:
                        reSendCode ? Text("Resend Code") : Text("Send Code")),
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
                  MaterialPageRoute(builder: (builder) => HomeScreen()));
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            print(exception.message);
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
                    title: Text("Enter Your Code"),
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
                                  shape: StadiumBorder(), primary: maincolor),
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
                                                HomeScreen()));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: e.message!,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP);
                                }
                              },
                              child: Text("Verify Code")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(), primary: maincolor),
                              onPressed: () async {
                                setState(() {
                                  reSendCode = true;
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      ),
                    ],
                  );
                });
            setState(() {
              this.verificationIDRecieved = verificationId;
            });
          },
          codeAutoRetrievalTimeout: ((verificationId) {
            setState(() {
              this.verificationIDRecieved = verificationId;
            });
          }),
          timeout: Duration(minutes: 2));
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
