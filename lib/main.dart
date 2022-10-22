import 'package:ecommerce/backend/AuthServices.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthServices authServices = AuthServices();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 18, 147, 164),
        textTheme: const TextTheme(
          headline1: TextStyle(
              letterSpacing: 0.5,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 18, 147, 164)),
          headline2: TextStyle(
              letterSpacing: 0.5,
              fontSize: 12.0,
              color: Color.fromARGB(255, 128, 126, 126)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: authServices.handleState(),
    );
  }
}
