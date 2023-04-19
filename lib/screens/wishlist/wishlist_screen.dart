import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/wishlist/wishlist_controller.dart';
import 'package:ride_with_rental/screens/wishlist/widgets/wishlist_item_view_widget.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});
  var controller = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          "Wishlist",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<WishlistController>(
        initState: (state) {
          controller.getWishListItems();
        },
        builder: (_) {
          return _.wishlistItems.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistItemViewWidget(
                      model: _.wishlistItems[index],
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No Items to show",
                  ),
                );
        },
      ),
    );
  }
}
