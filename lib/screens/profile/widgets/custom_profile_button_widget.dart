import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomProfileButtonWidget extends StatelessWidget {
  CustomProfileButtonWidget({
    super.key,
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.label,
    this.onTap,
  });

  BorderRadius? borderRadius;
  Color? textColor, backgroundColor;
  String? label;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: appWidth / 2.4,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            label ?? "",
            style: TextStyle(
              fontSize: 13,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
