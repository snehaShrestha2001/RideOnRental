import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/filter_data/filter_data_controller.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';
import 'package:ride_with_rental/controllers/profile/profile_controller.dart';
import 'package:ride_with_rental/widgets/custom_filter_item_widget.dart';

import '../../constants.dart';
import 'widgets/item_grid_view_widget.dart';
import 'widgets/search_bar_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: GetBuilder<ProfileController>(
          builder: (_) {
            return Text(
              "Hello! ${_.userDetailsModel.username ?? ""}",
              style: const TextStyle(
                color: Colors.black,
              ),
            );
          },
        ),
        actions: [
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                color: greyColor.withOpacity(.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: greyColor.withOpacity(.1),
                  )
                ]),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<FilterDataController>(builder: (_) {
                return CustomFilterItemWidget(
                  label: "Category: All",
                  categoryFilterList: const [
                    "All",
                    "Bike",
                    "Car",
                  ],
                  dropdownvalue: _.filterCategoryType,
                  type: FilterDataType.filterCategory,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: ItemGridViewWidget())
            ],
          ),
        ),
      ),
    );
  }
}
