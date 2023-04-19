import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/models/all_products/all_products_model.dart';

import '../../../constants.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../single_item/single_item_screen.dart';

class ItemViewWidget extends StatelessWidget {
  ItemViewWidget({
    super.key,
    required this.model,
  });

  var model = Products();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => SingleItemScreen(
          model: model,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: greyColor.withOpacity(.1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomImageWidget(
            image:
                model.productImage?.replaceFirst("localhost", "172.20.10.11") ??
                    "",
            fit: BoxFit.cover,
            height: appHeight * 0.12,
            width: appWidth / 2,
          ),
          Text(
            model.productName ?? "",
            style: const TextStyle(
              fontFamily: 'Poppins Medium',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "Rs. ${model.productPrice}",
            style: const TextStyle(
              fontFamily: 'Poppins Medium',
              // fontSize: 16,
            ),
          ),
          Text(
            "Seller : ${model.seller}",
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins Medium',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
      ),
    );
  }
}
