import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/wishlist/wishlist_controller.dart';
import 'package:ride_with_rental/screens/single_item/single_item_screen.dart';

import '../../../widgets/custom_image_widget.dart';

class WishlistItemViewWidget extends StatelessWidget {
  WishlistItemViewWidget({
    super.key,
    this.model,
  });

  var model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.to(SingleItemScreen(model: model)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageWidget(
                  image: model.productImage
                          ?.replaceFirst("localhost", "172.20.10.11") ??
                      "",
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.productName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins Medium',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "By ${model.seller}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs ${model.productPrice}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _.removeFromWishlist(model.wishlistId),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.delete_outline_rounded,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
