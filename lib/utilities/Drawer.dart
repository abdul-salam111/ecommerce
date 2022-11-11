import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebasework/backend/AuthServices.dart';
import 'package:firebasework/utilities/getProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget? profilePhoto;
  String? name;
  Map<String, dynamic>? data;
  void getuserdata() async {
    var collection = FirebaseFirestore.instance.collection('Registration');
    var docSnapshot = await collection.doc(userUid).get();
    if (docSnapshot.exists) {
      data = docSnapshot.data()!;
      setState(() {
        if (mounted) {
          name = data!['displayName'] + " " + data!['lastName'];
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getuserdata();
    userImage = FirebaseAuth.instance.currentUser!.photoURL;
    userName = FirebaseAuth.instance.currentUser!.displayName;
    userEmail = FirebaseAuth.instance.currentUser!.email;
    profilePhoto = getProfilePhoto(userImage, context, userEmail);
  }

  final userUid = FirebaseAuth.instance.currentUser!.uid;
  String? userImage;
  String? userName;
  String? userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: maincolor, width: 3)),
                child: profilePhoto,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Hi",
              style: TextStyle(
                  color: maincolor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            getName(),
            const SizedBox(height: 10),
            Text(
              "Email: ${userEmail!}",
              style: const TextStyle(
                fontSize: 17,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(
              thickness: 3,
              color: maincolor,
              height: 20,
              indent: 90,
              endIndent: 90,
            ),
            const Divider(
              color: maincolor,
            ),
            const ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: maincolor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: maincolor,
              ),
            ),
            const Divider(
              height: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "CartPage");
              },
              child: const ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: maincolor,
                ),
                title: Text(
                  "Cart",
                  style: TextStyle(color: maincolor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: maincolor,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            const ListTile(
              leading: Icon(
                Icons.card_giftcard,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Order",
                style: TextStyle(color: maincolor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: maincolor,
              ),
            ),
            const Divider(
              height: 0,
            ),
            const ListTile(
              leading: Icon(
                Icons.info,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "About",
                style: TextStyle(color: maincolor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: maincolor,
              ),
            ),
            const Divider(
              height: 0,
            ),
            const ListTile(
              leading: Icon(
                Icons.lock,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Change",
                style: TextStyle(color: maincolor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: maincolor,
              ),
            ),
            const Divider(
              height: 0,
            ),
            const ListTile(
              leading: Icon(
                Icons.phone,
                size: 30,
                color: maincolor,
              ),
              title: Text(
                "Contact",
                style: TextStyle(color: maincolor),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: maincolor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                AuthServices().googleSignOut(context);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  primary: maincolor,
                  shape: const StadiumBorder()),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  Widget getName() {
    if (userName == null) {
      return Text(
        name ?? "loading...",
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      );
    } else {
      return Text(userName!);
    }
  }
}
