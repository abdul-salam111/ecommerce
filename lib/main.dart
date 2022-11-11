import 'package:firebasework/AdminPanel/adminhomescreen.dart';
import 'package:firebasework/AdminPanel/manageProducts.dart';
import 'package:firebasework/Screens/SignInUser.dart';
import 'package:firebasework/Screens/UserRegistration.dart';
import 'package:firebasework/Screens/verifyWithOtp.dart';
import 'package:firebasework/checkout/addNewAddress.dart';
import 'package:firebasework/checkout/delivery.dart';
import 'package:firebasework/Providers/ReviewCartProvider.dart';
import 'package:firebasework/Screens/AddToCart.dart';
import 'package:firebasework/Screens/HomeScreen.dart';
import 'package:firebasework/Screens/navigation_Bar.dart';
import 'package:firebasework/Screens/productsDetail.dart';
import 'package:firebasework/Screens/seeAllProduc.dart';
import 'package:firebasework/utilities/Drawer.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'backend/AuthServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  AuthServices authServices = AuthServices();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReviewCartProvider>(
            create: (_) => ReviewCartProvider()),
      ],
      child: MaterialApp(
        routes: {
          "HomeScreen": ((context) => const HomeScreen()),
          "ProductDetail": (context) => ProductsDetail(),
          "NavigationBar": (context) => const NavigationBars(),
          "DeliveryDetail": (context) => DeliveryDetails(),
          "CartPage": (context) => const ReviewCart(),
          "SeeAllProducts": (context) => SeeAllProducts(),
          "MyAccount": (context) => const MyDrawer(),
          "AddNewAddress": (context) => const AddNewAddress(),
          "UserRegistration": (context) => const UserRegistration(),
          "SignInUser": (context) => const SignInUser(),
          "OtpVerification": (context) => const OtpVerification(),
          "HomeScreenAdmin": (context) => const HomeScreenPanel(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: maincolor,
          textTheme: const TextTheme(
            headline1: TextStyle(
                letterSpacing: 0.5,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: maincolor),
            headline2: TextStyle(
                letterSpacing: 0.5,
                fontSize: 12.0,
                color: Color.fromARGB(255, 128, 126, 126)),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: authServices.handleState(),
      ),
    );
  }
}
