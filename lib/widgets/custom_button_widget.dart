import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    this.title,
    this.onTap,
    this.margin,
    this.isForProfile = false,
  });

  String? title;
  Function()? onTap;
  EdgeInsets? margin;
  bool isForProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: margin,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: isForProfile == false
                ? [
                    BoxShadow(
                      color: greyColor.withOpacity(.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    )
                  ]
                : []),
        child: Center(
          child: Text(
            title ?? "",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
