import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/filter_data/filter_data_controller.dart';

import '../constants.dart';

class CustomFilterItemWidget extends StatelessWidget {
  CustomFilterItemWidget({
    super.key,
    this.label,
    required this.categoryFilterList,
    this.dropdownvalue,
    required this.type,
  });

  // Initial Selected Value
  String? dropdownvalue;
  FilterDataType type;

  @override
  Widget build(BuildContext context) {
    // Get.put(FilterDataController());
    return GetBuilder<FilterDataController>(builder: (_) {
      return Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text(
                label ?? "",
              ),
              buttonStyleData: ButtonStyleData(
                  elevation: 0,
                  decoration: BoxDecoration(
                      color: greyColor.withOpacity(.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)))),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              value: dropdownvalue,
              items: categoryFilterList
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                switch (type) {
                  case FilterDataType.price:
                    _.setDropDownValue(value, type);
                    break;
                  case FilterDataType.category:
                    _.setDropDownValue(value, type);
                    break;
                  case FilterDataType.condition:
                    _.setDropDownValue(value, type);
                    break;
                  case FilterDataType.filterCategory:
                    _.setDropDownValue(value, type);
                    break;
                }
              },
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ],
      );
    });
  }

  String? label;
  // List of items in our dropdown menu
  var categoryFilterList = [];
}
