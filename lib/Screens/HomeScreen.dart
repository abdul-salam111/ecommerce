import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasework/Screens/BurgerScreen.dart';
import 'package:firebasework/Screens/HotOffers.dart';
import 'package:firebasework/Screens/PizzazScreen.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:firebasework/Screens/seeAllProduc.dart';
import 'package:flutter/material.dart';
import '../backend/AuthServices.dart';

import '../utilities/getProfilePhoto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;
  String? userImage;
  Widget? UserProfileImage;
  @override
  void initState() {
    super.initState();
    userEmail = FirebaseAuth.instance.currentUser!.email;
    userImage = FirebaseAuth.instance.currentUser!.photoURL;
    UserProfileImage = getProfilePhoto(userImage, context, userEmail);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Funny Food",
          style: TextStyle(color: maincolor),
        ),
        centerTitle: true,
        leading: Image.asset("images/logo.png"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "MyAccount");
              },
              child: (UserProfileImage)),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hot Offers",
                      style: homescreenstyle,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See all",
                          style: seeAllbuttons,
                        ))
                  ],
                ),
              ),
              const HotOffers(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Burgers",
                      style: homescreenstyle,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SeeAllProducts(
                                        collection: FirebaseFirestore.instance
                                            .collection("Burgers"),
                                      )));
                        },
                        child: const Text(
                          "See all",
                          style: seeAllbuttons,
                        ))
                  ],
                ),
              ),
              const BurgerScreen(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Pizzaz",
                      style: homescreenstyle,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SeeAllProducts(
                                      collection: FirebaseFirestore.instance
                                          .collection("Pizzaz"))));
                        },
                        child: const Text(
                          "See all",
                          style: seeAllbuttons,
                        ))
                  ],
                ),
              ),
              const PizzaScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
