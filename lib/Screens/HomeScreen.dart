import 'package:ecommerce/backend/AuthServices.dart';
import 'package:ecommerce/utilities/Drawer.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final username = FirebaseAuth.instance.currentUser!.email;
  final image = FirebaseAuth.instance.currentUser!.photoURL;

  final auth = AuthServices();
  getphoto() {
    if (image == null) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => MyDrawer()));
        },
        child: CircleAvatar(
          backgroundColor: maincolor,
          radius: 22,
          child: Text(
            username![0].toUpperCase(),
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
          backgroundImage: NetworkImage(image!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              AuthServices().googleSignOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Padding(
        padding: const EdgeInsets.only(right: 5, top: 40),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => MyDrawer()));
                },
                child: Align(alignment: Alignment.topRight, child: getphoto()))
          ],
        ),
      ),
    );
  }
}
