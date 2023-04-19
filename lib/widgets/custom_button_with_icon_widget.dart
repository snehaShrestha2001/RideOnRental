import 'package:flutter/material.dart';

class CustomButtonWithIconWidget extends StatelessWidget {
  CustomButtonWithIconWidget({
    super.key,
    this.title,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.onTap,
    this.margin,
    this.fontSize,
    this.iconSize,
  });

  String? title;
  double? width, fontSize, iconSize;
  Color? backgroundColor, foregroundColor;
  IconData? icon;
  Function()? onTap;
  EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: width,
        margin: margin,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: foregroundColor,
              size: iconSize,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title ?? "",
              style: TextStyle(
                color: foregroundColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
