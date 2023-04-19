import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/app_controller.dart';
import 'package:ride_with_rental/screens/explore/explore_screen.dart';
import 'package:ride_with_rental/screens/profile/profile_screen.dart';

import '../login_checker/login_schecker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  var appController = Get.find<AppController>();
  var pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    pages = [
      const ExploreScreen(),
      if (appController.userType == "Customer") ...[LoginCheckerScreen()],
      ProfileScreen(),
    ];
    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: primaryColor,
          color: greyColor,
          tabBorderRadius: 10,
          haptic: false,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabs: [
            bottomNavigationBarItem(
              "Home",
              Icons.home_outlined,
            ),
            if (appController.userType == "Customer") ...[
              bottomNavigationBarItem(
                "Wishlist",
                Icons.favorite_border_outlined,
              ),
            ],
            bottomNavigationBarItem(
              "Profile",
              Icons.person_outlined,
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  bottomNavigationBarItem(String title, IconData icon) {
    return GButton(icon: icon, text: title);
  }
}
