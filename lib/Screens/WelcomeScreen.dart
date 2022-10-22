import 'package:ecommerce/Screens/SignInUser.dart';
import 'package:ecommerce/Screens/UserRegistration.dart';
import 'package:flutter/material.dart';

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
                    border: Border.all(
                        color: const Color.fromARGB(255, 18, 147, 164))),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignInUser()));
                      },
                      child: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 18, 147, 164),
                          shape: const StadiumBorder(),
                          minimumSize:
                              Size.fromHeight(screenSize.height / 18))),
                ),
                SizedBox(
                  height: screenSize.width / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => UserRegistration()));
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 147, 164),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              color: const Color.fromARGB(255, 18, 147, 164),
                              width: 2),
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
