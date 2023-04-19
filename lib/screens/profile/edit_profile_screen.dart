import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';

import '../../constants.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../widgets/custom_text_field_widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: GetBuilder<ProfileController>(
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            controller.getProfileDetails();
            controller.clearFields();
          });
        },
        builder: (_) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit your Profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: blackColor,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: _.updateProfilePic != null ? true : false,
                    child: Image.file(
                      height: 170,
                      width: appWidth,
                      fit: BoxFit.cover,
                      File(_.updateProfilePic?.path ?? ""),
                    ),
                  ),
                  Visibility(
                    visible: _.updateProfilePic == null ? true : false,
                    child: GestureDetector(
                      onTap: () {
                        _.getImage();
                      },
                      child: DottedBorder(
                        color: greyColor,
                        dashPattern: const [5, 5],
                        child: SizedBox(
                          height: 170,
                          width: appWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: greyColor,
                              ),
                              Text(
                                "Upload Your Profile Picture",
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
                  CustomTextFieldWidget(
                    label: _.userDetailsModel.username,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textController: _.updateNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    label: _.userDetailsModel.phoneNumber,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    textController: _.updatePhnNumController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    label: _.userDetailsModel.address,
                    textInputType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    textController: _.updateAddressController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButtonWidget(
                    title: "Update",
                    onTap: () => _.udpateProfile(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
