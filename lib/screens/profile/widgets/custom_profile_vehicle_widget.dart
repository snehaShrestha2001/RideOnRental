import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/custom_image_widget.dart';
import '../../../widgets/custom_seller_only_widget.dart';

class CustomProfileVehicleWidget extends StatelessWidget {
  CustomProfileVehicleWidget({
    super.key,
  });
  var appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(initState: (state) {
      if (appController.userType == "Seller") {
        Get.find<ProductController>().getSellerProduct();
      }
    }, builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Vehicle",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (_.productsList.isNotEmpty) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _.productsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageWidget(
                        image: _.productsList[index].productImage
                                ?.replaceFirst("localhost", "172.20.10.11") ??
                            "",
                        height: 200,
                        fit: BoxFit.cover,
                        width: appWidth,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.productsList[index].productName ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _.productsList[index].productCondition ?? 'N/A',
                            style: const TextStyle(
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Rs ${_.productsList[index].productPrice ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xffF46600),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          CustomButtonWidget(
            title: "Register your Vehicle here",
            onTap: () => Get.to(() => const CustomSellerOnlyWidget()),
          ),
        ],
      );
    });
  }
}
