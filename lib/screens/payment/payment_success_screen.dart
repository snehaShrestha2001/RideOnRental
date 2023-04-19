import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/screens/home/home_screen.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';
import 'package:ride_with_rental/widgets/custom_loading_widget.dart';

class PaymentSucessScreen extends StatelessWidget {
  const PaymentSucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: CustomLoadingWidget(
                lottie: "assets/lottie/payment-success.json",
                isRepeat: false,
              ),
            ),
            CustomButtonWidget(
              title: "Done",
              onTap: () => Get.off(() => const HomeScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
