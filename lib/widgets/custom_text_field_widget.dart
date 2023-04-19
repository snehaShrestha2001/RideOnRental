import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/authorization/authorization_controller.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget({
    super.key,
    this.label,
    this.textInputAction,
    this.textInputType,
    this.icon,
    this.showPrefixIcon = true,
    this.maxLines,
    this.isPassword = false,
    this.textController,
    this.validator,
  });

  String? label;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  IconData? icon;
  bool? showPrefixIcon, isPassword;
  int? maxLines;
  TextEditingController? textController;
  Function(String)? validator;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthorizationController>();
    return GetBuilder<AuthorizationController>(initState: (state) {
      controller.passwordSelected = false;
    }, builder: (_) {
      return TextFormField(
        controller: textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          hintText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: icon == null
                    ? greyColor.withOpacity(.4)
                    : Colors.transparent),
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                )
              : const SizedBox(),
          prefixIconConstraints: icon == null
              ? const BoxConstraints(
                  minWidth: 15,
                )
              : const BoxConstraints(
                  minHeight: 48,
                  minWidth: 48,
                ),
          suffixIcon: isPassword == true
              ? GestureDetector(
                  onTap: () {
                    _.clickPasword();
                  },
                  child: Icon(
                    _.passwordSelected
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : const SizedBox(),
        ),
        obscureText: isPassword == true
            ? _.passwordSelected
                ? false
                : true
            : false,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: isPassword == true ? 1 : maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return validator == null ? null : validator!(value ?? "");
        },
      );
    });
  }
}
