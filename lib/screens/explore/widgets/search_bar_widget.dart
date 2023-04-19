import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';

import '../../../constants.dart';
import '../../../controllers/search_product/search_product_controller.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(initState: (state) {
      Get.find<ProductController>().getAllProducts();
    }, builder: (_) {
      return GestureDetector(
        onTap: () {
          showSearch(
            context: context,
            delegate:
                SearchProductController(productsSearchList: _.allProductList),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: greyColor.withOpacity(.1),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: blackColor.withOpacity(.4),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Search Your Ride",
                style: TextStyle(
                  color: blackColor.withOpacity(.4),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
