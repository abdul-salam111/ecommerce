import 'package:auth_buttons/auth_buttons.dart';
import 'package:email_validator/email_validator.dart';

import 'package:firebasework/backend/SignIn.dart';
import 'package:flutter/material.dart';

import '../backend/AuthServices.dart';
import '../utilities/constants.dart';
import 'UserRegistration.dart';
import 'forgetPassword.dart';

class SignInUser extends StatefulWidget {
  const SignInUser({Key? key}) : super(key: key);

  @override
  State<SignInUser> createState() => _SignInUserState();
}

class _SignInUserState extends State<SignInUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailcontoller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool _ispasswordVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ispasswordVisible = false;
  }

  SigningInUser signingInUser = SigningInUser();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: maincolor,
                          size: 30,
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        border: Border.all(color: maincolor)),
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
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Email(),
                          const SizedBox(
                            height: 20,
                          ),
                          Password(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const UserRegistration()));
                                  },
                                  child: const Text(
                                    "Don't have an account?",
                                    style: TextStyle(color: maincolor),
                                  )),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const ForgetPassword()));
                                },
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(color: TextFieldColor),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const UserRegistration()));
                                  },
                                  child: const Text(
                                    "Don't have an account?",
                                    style: TextStyle(color: TextFieldColor),
                                  )),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const ForgetPassword()));
                                },
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(color: maincolor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height / 12,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: maincolor,
                                  minimumSize: const Size(double.infinity, 40)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  String email = emailcontoller.text.trim();
                                  if (email == "abdulsalam.0302@gmail.com" &&
                                      passwordcontroller.text == "salam0302") {
                                    Navigator.pushReplacementNamed(
                                        context, "HomeScreenAdmin");
                                  } else {
                                    signingInUser.userSigin(
                                        email,
                                        passwordcontroller.text.trim(),
                                        context);
                                  }
                                }
                              },
                              child: const Text("SignIn")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: maincolor,
                                  minimumSize: const Size(double.infinity, 40)),
                              onPressed: () {
                                Navigator.pushNamed(context, "OtpVerification");
                              },
                              child: const Text("Login With Otp")),
                          GoogleAuthButton(
                            onPressed: () async {
                              await authServices.signinWithGoogle(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, "HomeScreen");
                            },
                            style: const AuthButtonStyle(
                                width: double.infinity,
                                borderRadius: 50,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                buttonColor: maincolor,
                                iconType: AuthIconType.secondary,
                                height: 40),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  AuthServices authServices = AuthServices();
  // ignore: non_constant_identifier_names
  Widget Email() {
    return SizedBox(
      height: 50,
      child: TextFormField(
          validator: (value) {
            EmailValidator.validate(value!);
          },
          controller: emailcontoller,
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

  Widget Password() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "password can't be empty";
          } else if (RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])$')
              .hasMatch(value)) {
            return "Password should be of 8 characters";
          } else {
            return null;
          }
        },
        obscureText: !_ispasswordVisible,
        controller: passwordcontroller,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _ispasswordVisible = !_ispasswordVisible;
                });
              },
              icon: Icon(
                _ispasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: maincolor,
              ),
            ),
            prefixIcon: const Icon(
              Icons.key,
              color: maincolor,
            ),
            label: const Text("Password"),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: maincolor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: maincolor, width: 2))),
      ),
    );
  }
}
