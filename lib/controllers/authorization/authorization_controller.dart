import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/app_controller.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';
import 'package:ride_with_rental/screens/home/home_screen.dart';

import '../../api/authorization/authorization_api.dart';
import '../../screens/authorization/login_screen.dart';

class AuthorizationController extends GetxController {
  bool passwordSelected = false;

  // for login
  var phnNumController = TextEditingController();
  var passwordController = TextEditingController();

  // for registration
  var registerPhnController = TextEditingController();
  var registerPassController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();

  var appController = Get.find<AppController>();
  var productController = Get.find<ProductController>();
  var customerText = "Seller";
  bool isCustomer = false;

  void checkCustomerOrSeller(value) {
    isCustomer = !isCustomer;
    if (!value) {
      customerText = "Customer";
    } else {
      customerText = "Renter";
    }
    update();
  }

  clickPasword() {
    passwordSelected = !passwordSelected;
    update();
  }

  String? get errorText {
    final text = phnNumController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 9) {
      return 'Too short';
    }
    return null;
  }

  Future login() async {
    String phnNum = phnNumController.text.trim();
    String password = passwordController.text.trim();
    try {
      var response = await AuthorizationApi.login(phnNum, password);
      if (response.error != null && response.error == false) {
        clearFields(false);
        appController.isLoggedIn = true;
        Get.offAll(() => const HomeScreen());
      } else {
        Get.rawSnackbar(message: response.message);
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = e.toString();
      }
      Get.rawSnackbar(message: errorMessage);
    }
  }

  Future register() async {
    String phnNum = registerPhnController.text.trim();
    String password = registerPassController.text.trim();
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    try {
      var response = await AuthorizationApi.register(
        phnNum: phnNum,
        password: password,
        name: name,
        address: address,
        userType: customerText,
      );

      if (response.error != null && response.error == false) {
        // if (!isCustomer) {
        //   productController.uploadProduct();
        // }
        clearFields(true);
        Get.rawSnackbar(message: "You are successfully registered");
        Get.off(() => const LoginScreen());
      } else {
        Get.rawSnackbar(message: response.message);
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = e.toString();
      }
      Get.rawSnackbar(message: errorMessage);
    }
  }

  void clearFields(bool isRegister) {
    if (isRegister) {
      // for registration
      registerPhnController.clear();
      registerPassController.clear();
      nameController.clear();
      addressController.clear();
    } else {
      // for login
      phnNumController.clear();
      passwordController.clear();
    }
  }

  @override
  void dispose() {
    phnNumController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    registerPhnController.dispose();
    registerPassController.dispose();
    super.dispose();
  }
}
