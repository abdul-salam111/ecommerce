import 'package:ecommerce/Screens/SignInUser.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utilities/constants.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final resetEmailController = TextEditingController();
  Widget Email() {
    return SizedBox(
      height: 50,
      child: TextFormField(
          validator: (value) {
            EmailValidator.validate(value!);
          },
          controller: resetEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            label: Text("Email"),
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
              msg: "Verification has been successfully send to Gmail!")
          .then((value) {
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: maincolor,
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => SignInUser()));
                },
                child: Image.asset('images/logo.png')),
            leadingWidth: 50,
            title: const Text("Forget Password")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Container(
                    child: Image.asset('images/logo.png'),
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Email(),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: maincolor,
                                    minimumSize: Size(double.infinity, 50)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    resetPassword(
                                        resetEmailController.text.trim());
                                  }
                                },
                                child: Text("Send Request")),
                          ]))
                ]))));
  }
}
