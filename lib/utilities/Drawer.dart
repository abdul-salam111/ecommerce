import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Screens/SignInUser.dart';
import 'package:ecommerce/backend/AuthServices.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final userImage = FirebaseAuth.instance.currentUser!.photoURL;
  final user = FirebaseAuth.instance.currentUser;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: maincolor,
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: UserAccountsDrawerHeader(
                    currentAccountPicture: getphoto(),
                    accountName: Text(userEmail!),
                    accountEmail: Text(userEmail!))),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  AuthServices().googleSignOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => SignInUser()));
                },
              ),
            )
          ],
        ));
  }

  getphoto() {
    if (userImage == null) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => MyDrawer()));
        },
        child: CircleAvatar(
          backgroundColor: maincolor,
          radius: 22,
          child: Text(
            userEmail![0].toUpperCase(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => MyDrawer()));
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(userImage!),
        ),
      );
    }
  }
}
