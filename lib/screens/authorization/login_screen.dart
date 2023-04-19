import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/authorization/authorization_controller.dart';
import 'package:ride_with_rental/screens/authorization/registration_screen.dart';

import '../../constants.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthorizationController>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              "assets/images/login-image.png",
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: appHeight / 1.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Color(0xffF4F5F9),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome back !",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const Text(
                      "Sign in to your account",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFieldWidget(
                      label: "Phone Number",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      icon: Icons.phone_outlined,
                      textController: controller.phnNumController,
                      validator: (value) {
                        if (value.isEmpty == true) {
                          return "Phone Number Can't be empty";
                        } else if (value.length < 10) {
                          return "Phone number must have 10 characters";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldWidget(
                      label: "Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      textController: controller.passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password Can't be empty";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                      title: "Login",
                      onTap: () {
                        controller.login();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationScreen());
                        controller.clearFields(false);
                      },
                      child: const Text.rich(
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(
                              color: blackColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
