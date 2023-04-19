import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/authorization/authorization_controller.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';

import '../../widgets/custom_text_field_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xffF4F5F9),
          elevation: 0,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color(0xffF4F5F9),
        body: GetBuilder<AuthorizationController>(builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcom ${_.isCustomer ? "Customer !" : "Seller !"}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Register Your Account  here',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(
                  label: "Your Name",
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textController: _.nameController,
                  validator: (value) {
                    if (value.isEmpty == true) {
                      return "Name Can't be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldWidget(
                  label: "Phone Number",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textController: _.registerPhnController,
                  validator: (value) {
                    if (value.isEmpty == true) {
                      return "Phone Number Can't be empty";
                    } else if (value.length < 10) {
                      return "Phone number must have 10 characters";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldWidget(
                  label: "Location",
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textController: _.addressController,
                  validator: (value) {
                    if (value.isEmpty == true) {
                      return "Address Can't be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldWidget(
                  label: "Password",
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  isPassword: true,
                  textController: _.registerPassController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password Can't be empty";
                    } else if (value.length < 8) {
                      return "Password must atleast have 8 characters";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Switch(
                      value: !_.isCustomer,
                      activeColor: primaryColor,
                      onChanged: (bool value) {
                        _.checkCustomerOrSeller(value);
                      },
                    ),
                    Text(
                      "Turn it ${_.isCustomer ? "on" : "off"}, If you're a ${_.isCustomer ? "Seller" : "Customer"}",
                      style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                CustomButtonWidget(
                  title: "Save Account",
                  onTap: () {
                    _.register();
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
