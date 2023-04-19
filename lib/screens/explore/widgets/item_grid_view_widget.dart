import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';

import '../../../widgets/custom_loading_widget.dart';
import 'item_view_widget.dart';

class ItemGridViewWidget extends StatelessWidget {
  const ItemGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return GetBuilder<ProductController>(initState: (state) {
      controller.getAllProducts();
    }, builder: (_) {
      return _.isLoading == false
          ? GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _.filteredProductList.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                mainAxisExtent: appHeight/4,
              ),
              itemBuilder: (context, index) {
                return ItemViewWidget(
                  model: _.filteredProductList[index],
                );
              },
            )
          : CustomLoadingWidget(
              lottie: "assets/lottie/loading.json",
              height: 170,
              width: 170,
            );
    });
  }
}
