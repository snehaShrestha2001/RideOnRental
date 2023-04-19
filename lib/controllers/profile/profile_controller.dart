import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_with_rental/models/authorization/authorization_model.dart';

import '../../api/authorization/authorization_api.dart';
import '../app_controller.dart';

class ProfileController extends GetxController {
  XFile? updateProfilePic;

  var appController = Get.find<AppController>();

  // for updating profile
  var updateNameController = TextEditingController();
  var updatePhnNumController = TextEditingController();
  var updateAddressController = TextEditingController();

  // change password
  var currentPassController = TextEditingController();
  var newPassController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  var userDetailsModel = AuthorizationModel();

  void getImage() async {
    updateProfilePic = await imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future getProfileDetails() async {
    try {
      var response = await AuthorizationApi.getUserDetails(
        apiKey: appController.apiKey,
      );

      if (response.error != null && response.error == false) {
        userDetailsModel = response;
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

  clearFields({bool? isForUpdate = true}) {
    if (isForUpdate == true) {
      updateProfilePic = null;
      updateNameController.clear();
      updatePhnNumController.clear();
      updateAddressController.clear();
    } else {
      currentPassController.clear();
      newPassController.clear();
    }
  }

  Future udpateProfile() async {
    String updateName = updateNameController.text.trim();
    String updatePhnNum = updatePhnNumController.text.trim();
    String updateAddress = updateAddressController.text.trim();

    try {
      var response = await AuthorizationApi.updateProfile(
        updateName: updateName,
        updatePhnNum: updatePhnNum,
        updateAddress: updateAddress,
        updateProfilePic: updateProfilePic,
      );

      if (response.error != null && response.error == false) {
        clearFields();
        getProfileDetails();
        Get.back();
        Get.rawSnackbar(message: "Profile updated successfully");
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

  Future changePassword() async {
    String newPassword = newPassController.text.trim();

    try {
      var response = await AuthorizationApi.changePassword(
        newPassword: newPassword,
        apiKey: appController.apiKey,
      );

      if (response.error != null && response.error == false) {
        clearFields(isForUpdate: false);
        getProfileDetails();
        Get.back();
        Get.rawSnackbar(message: "Password changed successfully");
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
}
