import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  CustomImageWidget({
    super.key,
    this.image,
    this.width,
    this.height,
    this.fit,
    this.isLocalImage,
    this.radius = 5,
  });
  String? image;
  double? width, height;
  BoxFit? fit;
  bool? isLocalImage;
  double? radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      child: isLocalImage == true
          ? Image.asset(
              image ?? "",
              fit: fit,
              height: height ?? 70,
              width: width ?? 70,
            )
          : CachedNetworkImage(
              imageUrl: image ?? "",
              fit: fit,
              height: height ?? 70,
              width: width ?? 70,
              errorWidget: (context, url, error) {
                return Image.asset(
                  "assets/images/logo.png",
                );
              },
            ),
    );
  }
}
