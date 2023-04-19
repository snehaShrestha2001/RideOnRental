import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';

import '../constants.dart';
import '../controllers/filter_data/filter_data_controller.dart';
import 'custom_text_field_widget.dart';
import 'custom_filter_item_widget.dart';

class CustomSellerOnlyWidget extends StatelessWidget {
  const CustomSellerOnlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterDataController>(builder: (_) {
      return GetBuilder<ProductController>(builder: (productController) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register Your Vehicle here',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    label: "Car/Bike Name",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textController: productController.productNameController,
                    validator: (value) {
                      if (value.isEmpty == true) {
                        return "Vehicle Name Can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: productController.imageFile != null ? true : false,
                    child: Image.file(
                      height: 200,
                      width: appWidth,
                      fit: BoxFit.cover,
                      File(productController.imageFile?.path ?? ""),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      productController.getImage();
                    },
                    child: Visibility(
                      visible:
                          productController.imageFile == null ? true : false,
                      child: DottedBorder(
                        color: greyColor,
                        dashPattern: const [5, 5],
                        child: SizedBox(
                          height: 200,
                          width: appWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: greyColor,
                              ),
                              Text(
                                "Add Image",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWidget(
                          label: "Price",
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          textController: productController.priceController,
                          validator: (value) {
                            if (value.isEmpty == true) {
                              return "Price Can't be empty";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomFilterItemWidget(
                        label: "Price Type",
                        categoryFilterList: const [
                          "Fixed",
                          "Negotiable",
                        ],
                        dropdownvalue: _.selectedPriceType,
                        type: FilterDataType.price,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomFilterItemWidget(
                        label: "Category",
                        categoryFilterList: const [
                          "Bike",
                          "Car",
                        ],
                        dropdownvalue: _.selectedCategoryType,
                        type: FilterDataType.category,
                      ),
                      CustomFilterItemWidget(
                        label: "Condition",
                        categoryFilterList: const [
                          "New",
                          "Old",
                        ],
                        dropdownvalue: _.selectedConditionType,
                        type: FilterDataType.condition,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    label: "Color",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textController: productController.colorController,
                    validator: (value) {
                      if (value.isEmpty == true) {
                        return "Color Can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldWidget(
                    label: "Condition",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textController: productController.durationController,
                    validator: (value) {
                      if (value.isEmpty == true) {
                        return "Condition Can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldWidget(
                    label: "Features",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 2,
                    textController: productController.featuresController,
                    validator: (value) {
                      if (value.isEmpty == true) {
                        return "Features Can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldWidget(
                    label: "Description",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 5,
                    textController: productController.descriptionController,
                    validator: (value) {
                      if (value.isEmpty == true) {
                        return "Description Can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonWidget(
                    title: "Upload Vehicle",
                    onTap: () {
                      productController.uploadProduct();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
