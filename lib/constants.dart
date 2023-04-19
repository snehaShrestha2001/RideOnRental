import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color primaryColor = Color(0xffFCCA01);
const Color blackColor = Colors.black54;
const Color greyColor = Colors.grey;

final appWidth = Get.width;
final appHeight = Get.height;

enum FilterDataType {
  price,
  category,
  condition,
  filterCategory,
}

const String baseUrl = "http://172.20.10.11/api/";
