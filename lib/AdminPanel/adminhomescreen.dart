import 'package:firebasework/AdminPanel/adminAccount.dart';
import 'package:firebasework/AdminPanel/manageProducts.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../backend/AuthServices.dart';

class HomeScreenPanel extends StatefulWidget {
  const HomeScreenPanel({Key? key}) : super(key: key);

  @override
  State<HomeScreenPanel> createState() => _HomeScreenPanelState();
}

class _HomeScreenPanelState extends State<HomeScreenPanel> {
  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: "Welcome to the Admin panel");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminAccount(),
      appBar: AppBar(
        backgroundColor: maincolor,
        title: const Text("Admin Panel"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              children: const [
                Text(
                  "Welcome,",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              products("Burgers", "images/burger.jpg", "Burgers"),
              products("Pizzaz", "images/pizza.jpg", "Pizzaz"),
            ],
          )
        ],
      ),
    );
  }

  Widget products(String productName, image, reference) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => AllProducts(
                      collection: reference,
                    )));
      },
      child: Container(
        height: screenSize.height / 10,
        width: screenSize.width / 3.5,
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.5, image: AssetImage(image), fit: BoxFit.cover)),
        child: Center(child: Text(productName)),
      ),
    );
  }
}
