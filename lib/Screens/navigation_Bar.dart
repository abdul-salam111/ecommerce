import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebasework/Providers/ReviewCartProvider.dart';
import 'package:firebasework/Screens/AddToCart.dart';
import 'package:firebasework/utilities/Drawer.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({Key? key}) : super(key: key);

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const ReviewCart(),
    const MyDrawer(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final reviewcart = Provider.of<ReviewCartProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: maincolor,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.note_add_outlined),
              title: const Text('Orders'),
              activeColor: maincolor),
          BottomNavyBarItem(
              icon: Badge(
                badgeContent: Consumer<ReviewCartProvider>(
                    builder: (context, value, child) {
                  return Text(reviewcart.Counter.toString());
                }),
                child: const Icon(Icons.shopping_cart),
              ),
              title: const Text('Cart'),
              activeColor: maincolor),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: maincolor),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
