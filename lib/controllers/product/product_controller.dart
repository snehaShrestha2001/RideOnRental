import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_with_rental/api/product/product_api.dart';
import 'package:ride_with_rental/controllers/app_controller.dart';
import 'package:ride_with_rental/models/all_products/all_products_model.dart';

import '../../constants.dart';

class ProductController extends GetxController {
  var allProductList = <Products>[];
  var isLoading = false;
  var errorMessage = "";
  var filteredProductList = <Products>[];

  var productNameController = TextEditingController();
  var priceController = TextEditingController();
  var colorController = TextEditingController();
  var durationController = TextEditingController();
  var featuresController = TextEditingController();
  var descriptionController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  var controller = Get.find<AppController>();

  String? priceType, category, condition;

  XFile? imageFile;

  var productsList = <Products>[];

  void getImage() async {
    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> getAllProducts() async {
    isLoading = true; //isLoading = true;
    try {
      allProductList = await ProductApi.getAllProducts();
      filteredProductList = allProductList;
      isLoading = false;
      update();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = "Failed to load products";
      }
      errorMessage = e.toString();
    }
  }

  void filterProduct(String type) {
    if (type == "All") {
      filteredProductList = allProductList;
    } else {
      filteredProductList = allProductList
          .where((element) => element.productType == type)
          .toList();
    }
    update();
  }

  getDropDownValues(var value, FilterDataType type) {
    switch (type) {
      case FilterDataType.price:
        priceType = value;
        break;
      case FilterDataType.category:
        category = value;
        break;
      case FilterDataType.condition:
        condition = value;
        break;
      default:
        break;
    }
    update();
  }

  void clearFields() {
    productNameController.clear();
    priceController.clear();
    colorController.clear();
    durationController.clear();
    featuresController.clear();
    descriptionController.clear();
    imageFile = null;
  }

  Future uploadProduct() async {
    String productName = productNameController.text.trim();
    String price = priceController.text.trim();
    String color = colorController.text.trim();
    String duration = durationController.text.trim();
    String features = featuresController.text.trim();
    String description = descriptionController.text.trim();

    try {
      var response = await ProductApi.uploadProduct(
        apiKey: controller.apiKey,
        name: productName,
        price: price,
        color: color,
        condition: condition,
        features: features,
        description: description,
        duration: duration,
        type: category,
        priceType: priceType,
        imageFile: imageFile,
      );

      if (response.error != null && response.error == false) {
        getSellerProduct();
        clearFields();
        Get.back();
        Get.rawSnackbar(message: "Vehicle uploaded successfully");
        update();
      } else {
        Get.rawSnackbar(message: response.message);
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = e.toString();
      }
      Get.rawSnackbar(message: errorMessage);
    }
  }

  Future<void> getSellerProduct() async {
    try {
      productsList = await ProductApi.getSellerProduct(
        apiKey: controller.apiKey,
      );
      update();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = "Failed to load products";
      }
      errorMessage = e.toString();
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    colorController.dispose();
    durationController.dispose();
    featuresController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
