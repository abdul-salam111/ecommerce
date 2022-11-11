// ignore: file_names
import 'package:flutter/material.dart';

import '../utilities/constants.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Column(
              children: [
                Text(
                  "Welcome to Good Taste",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Order food from our Resturant and\n make reservation in real-time",
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "SignInUser");
                      },
                      style: ElevatedButton.styleFrom(
                          primary: maincolor,
                          shape: const StadiumBorder(),
                          minimumSize:
                              Size.fromHeight(screenSize.height / 18)),
                      child: const Text("Login")),
                ),
                SizedBox(
                  height: screenSize.width / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "UserRegistration");
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: maincolor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: maincolor, width: 2),
                          minimumSize:
                              Size.fromHeight(screenSize.height / 18))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
