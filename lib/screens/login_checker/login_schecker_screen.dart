import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_controller.dart';
import '../authorization/login_screen.dart';
import '../wishlist/wishlist_screen.dart';

class LoginCheckerScreen extends StatelessWidget {
  LoginCheckerScreen({super.key});

  var controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return controller.isLoggedIn == true
        ? WishlistScreen()
        : const LoginScreen();
  }
}
