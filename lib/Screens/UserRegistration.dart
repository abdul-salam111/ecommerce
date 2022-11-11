import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasework/Screens/verfiyEmail.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../modals/registrationModal.dart';
import '../utilities/constants.dart';
import 'SignInUser.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);
  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool? ispasswordVisible;
  bool? isconpasswordVisible;
  @override
  void initState() {
    super.initState();
    ispasswordVisible = false;
    isconpasswordVisible = false;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final emailcontoller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  Widget FirstName() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "First name can't be empty";
          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            return "correct your first name";
          } else {
            return null;
          }
        },
        controller: firstnamecontroller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: maincolor, width: 2)),
          prefixIcon: const Icon(
            Icons.person,
            color: maincolor,
          ),
          label: const Text("Firt name"),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: maincolor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget LastName() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Last name can't be empty*";
          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            return "correct your last name";
          } else {
            return null;
          }
        },
        controller: lastnamecontroller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: maincolor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: maincolor, width: 2)),
          prefixIcon: const Icon(
            Icons.person,
            color: maincolor,
          ),
          label: const Text("Last name"),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget Email() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: (value) {
          EmailValidator.validate(value!);
        },
        controller: emailcontoller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: maincolor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: maincolor, width: 2)),
          prefixIcon: const Icon(
            Icons.email,
            color: maincolor,
          ),
          label: const Text("Email"),
        ),
      ),
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
        controller: passwordcontroller,
        obscureText: !ispasswordVisible!,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: maincolor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: maincolor, width: 2)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  ispasswordVisible = !ispasswordVisible!;
                });
              },
              icon: Icon(
                ispasswordVisible! ? Icons.visibility : Icons.visibility_off,
                color: maincolor,
              )),
          prefixIcon: const Icon(
            Icons.key,
            color: maincolor,
          ),
          label: const Text("Password"),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget ConfirmPassword() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: !isconpasswordVisible!,
        validator: (value) {
          if (passwordcontroller.text != value) {
            return "Passwords are not matching";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: maincolor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: maincolor, width: 2)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isconpasswordVisible = !isconpasswordVisible!;
                });
              },
              icon: Icon(
                ispasswordVisible! ? Icons.visibility : Icons.visibility_off,
                color: maincolor,
              )),
          prefixIcon: const Icon(
            Icons.key,
            color: maincolor,
          ),
          label: const Text("Confirm Password"),
          border: const OutlineInputBorder(),
        ),
        controller: confirmpasswordcontroller,
      ),
    );
  }

 

  @override
  void dispose() {
    super.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailcontoller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const SignInUser()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset('images/logo.png'))),
          leadingWidth: 55,
          backgroundColor: maincolor,
          title: const Text("Registration"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: maincolor, width: 5),
                    borderRadius: BorderRadius.circular(120)),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width / 4,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        FirstName(),
                        const SizedBox(
                          height: 10,
                        ),
                        LastName(),
                        const SizedBox(
                          height: 10,
                        ),
                        Email(),
                        const SizedBox(
                          height: 10,
                        ),
                        Password(),
                        const SizedBox(
                          height: 10,
                        ),
                        ConfirmPassword(),
                        SizedBox(height: screenSize.height / 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: maincolor,
                                shape: const StadiumBorder(),
                                minimumSize: const Size(double.infinity, 50)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await SignUP(emailcontoller.text,
                                    passwordcontroller.text);
                              }
                            },
                            child: const Text("Register"))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
