import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';

class FilterDataController extends GetxController {
  String? selectedPriceType,
      selectedCategoryType,
      selectedConditionType,
      filterCategoryType;

  var productController = Get.find<ProductController>();

  setDropDownValue(var value, FilterDataType type) {
    switch (type) {
      case FilterDataType.price:
        selectedPriceType = value;
        productController.getDropDownValues(selectedPriceType, type);
        break;
      case FilterDataType.category:
        selectedCategoryType = value;
        productController.getDropDownValues(selectedCategoryType, type);
        break;
      case FilterDataType.condition:
        selectedConditionType = value;
        productController.getDropDownValues(selectedConditionType, type);
        break;
      case FilterDataType.filterCategory:
        filterCategoryType = value;
        productController.filterProduct(filterCategoryType ?? "");
        break;
    }
    update();
  }
}
