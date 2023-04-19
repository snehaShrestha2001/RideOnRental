import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/controllers/profile/profile_controller.dart';

import '../../constants.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
      body: GetBuilder<ProfileController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 20,
                  color: blackColor,
                  fontFamily: 'Poppins Medium',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                label: "Current Password",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                textController: _.currentPassController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password Can't be empty";
                  } else if (value != _.userDetailsModel.password) {
                    return "Please enter the correct password";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                label: "New Password",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                textController: _.newPassController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password Can't be empty";
                  } else if (value.length < 8) {
                    return "Phone number must atleast contain 8 characters";
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButtonWidget(
                title: "Change password",
                onTap: () => _.changePassword(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
