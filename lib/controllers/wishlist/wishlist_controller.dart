import 'package:get/get.dart';
import 'package:ride_with_rental/models/all_products/all_products_model.dart';

import '../../api/wishlist/wishlist_api.dart';
import '../app_controller.dart';

class WishlistController extends GetxController {
  static final controller = Get.find<AppController>();
  var wishlistItems = <Products>[];

  static String apiKey = controller.apiKey;
  bool isLoading = false;

  Future getWishListItems() async {
    wishlistItems = await WishlistApi.get(apiKey: apiKey);
    update();
  }

  Future addToWishlist(int productId) async {
    try {
      isLoading = true;
      if (wishlistItems
              .firstWhereOrNull((element) => element.productId == productId) ==
          null) {
        var response = await WishlistApi.add(
            apiKey: controller.apiKey, productId: productId.toString());
        isLoading = false;
        if (response.error != null && response.error == false) {
          Get.rawSnackbar(
            message: "Vehicle added to Wishlist Successfully",
            duration: const Duration(seconds: 1),
          );
          getWishListItems();
        } else {
          Get.rawSnackbar(message: response.message);
        }
      } else {
        Get.rawSnackbar(
          message: "Vehicle already on Wishlist",
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      isLoading = false;
      String errorMessage;
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = e.toString();
      }
      Get.rawSnackbar(message: errorMessage);
    }
    update();
  }

  Future removeFromWishlist(int wishlistId) async {
    try {
      isLoading = true;
      var response = await WishlistApi.remove(
          apiKey: apiKey, wishlistId: wishlistId.toString());

      isLoading = false;
      if (response.error != null && response.error == false) {
        wishlistItems
            .removeWhere((element) => element.wishlistId == wishlistId);

        Get.rawSnackbar(
          message: "Vehicle removed Successfully",
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.rawSnackbar(message: response.message);
      }
    } catch (e) {
      isLoading = false;
      String errorMessage;
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = e.toString();
      }
      Get.rawSnackbar(message: errorMessage);
    }

    update();
  }

  clearWishlist() {
    wishlistItems = [];
    update();
  }
}
