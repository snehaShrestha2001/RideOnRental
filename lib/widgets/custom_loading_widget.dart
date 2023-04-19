import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  CustomLoadingWidget({
    super.key,
    this.lottie,
    this.height,
    this.width,
    this.isRepeat = true,
  });

  String? lottie;
  double? height, width;
  bool? isRepeat;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottie ?? "",
      width: width,
      height: height,
      repeat: isRepeat,
    );
  }
}
