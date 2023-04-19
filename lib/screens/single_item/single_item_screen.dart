import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/app_controller.dart';
import 'package:ride_with_rental/controllers/single_item/single_item_controller.dart';
import 'package:ride_with_rental/models/all_products/all_products_model.dart';
import 'package:ride_with_rental/screens/authorization/login_screen.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';

import '../../controllers/payment/payment_controller.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../widgets/custom_button_with_icon_widget.dart';
import '../../widgets/custom_image_widget.dart';

class SingleItemScreen extends StatelessWidget {
  SingleItemScreen({
    super.key,
    required this.model,
  });

  var model = Products();
  var controller = Get.find<SingleItemController>();
  var wishlistController = Get.find<WishlistController>();
  var paymentController = Get.find<PaymentController>();
  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          model.productName ?? "",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: GetBuilder<WishlistController>(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageWidget(
                      image: model.productImage
                              ?.replaceFirst("localhost", "172.20.10.11") ??
                          "",
                      width: appWidth,
                      isLocalImage: false,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "NPR ${model.productPrice}",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.productName ?? "",
                      style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Seller : ${model.seller}",
                      style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Seller Contact: ${model.sellerPhnNum}",
                      style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "About Product",
                      style: TextStyle(
                        fontFamily: 'Poppins Medium',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.productDescription ?? "",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Specifications",
                      style: TextStyle(
                        fontFamily: 'Poppins Medium',
                      ),
                    ),
                    Divider(
                      color: blackColor,
                      endIndent: appWidth / 1.5,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ColoredBox(
                          color: index.isOdd
                              ? Colors.white
                              : const Color(0xffF5F5F5),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 6,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    index == 0
                                        ? "Features"
                                        : index == 1
                                            ? "Color"
                                            : "Used For",
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    index == 0
                                        ? model.productFeatures ?? ""
                                        : index == 1
                                            ? model.productColor ?? ""
                                            : model.productDuration ??
                                                "Used For",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            appController.isLoggedIn == true &&
                    appController.userType == "Customer"
                ? model.status == "booked"
                    ? CustomButtonWidget(
                        title: "Booked",
                      )
                    : Row(
                        children: [
                          CustomButtonWithIconWidget(
                            title: "Add to Wishlist",
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            icon: Icons.favorite_border_outlined,
                            width: appWidth / 2,
                            onTap: () => _.addToWishlist(model.productId ?? 0),
                          ),
                          CustomButtonWithIconWidget(
                            title: "Book Now",
                            backgroundColor: primaryColor,
                            width: appWidth / 2,
                            icon: Icons.sell_outlined,
                            foregroundColor: Colors.white,
                            onTap: () {
                              paymentController.checkout(
                                context: context,
                                payAmout: model.productPrice ?? 0,
                                productId: model.productId,
                                productName: model.productName,
                              );
                            },
                          ),
                        ],
                      )
                : CustomButtonWidget(
                    title: "Login to proceed",
                    onTap: () => Get.to(const LoginScreen()),
                  )
          ],
        );
      }),
      floatingActionButton: appController.isLoggedIn == true &&
              appController.userType == "Customer"
          ? model.status == "booked"
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 55),
                  child: FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed: () =>
                        controller.makePhoneCall(model.sellerPhnNum ?? ""),
                    child: const Icon(Icons.call),
                  ),
                )
          : const SizedBox(),
    );
  }
}
