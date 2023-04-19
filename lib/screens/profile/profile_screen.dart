import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/app_controller.dart';
import 'package:ride_with_rental/screens/authorization/login_screen.dart';
import 'package:ride_with_rental/screens/profile/change_passwod_screen.dart';
import 'package:ride_with_rental/screens/profile/edit_profile_screen.dart';
import 'package:ride_with_rental/widgets/custom_button_widget.dart';

import '../../controllers/profile/profile_controller.dart';
import '../../widgets/custom_image_widget.dart';
import 'widgets/custom_profile_button_widget.dart';
import 'widgets/custom_profile_vehicle_widget.dart';
import 'widgets/custom_view_payment_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  var controller = Get.find<ProfileController>();
  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(
        initState: (state) {
          if (appController.isLoggedIn == true) {
            controller.getProfileDetails();
          }
        },
        builder: (_) {
          return appController.isLoggedIn == true
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: _.userDetailsModel.profilePic == null
                                    ? Image.asset(
                                        "assets/images/user.png",
                                      )
                                    : CustomImageWidget(
                                        image: _.userDetailsModel.profilePic
                                                ?.replaceFirst("localhost",
                                                    "172.20.10.11") ??
                                            "",
                                        fit: BoxFit.cover,
                                        radius: 60,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _.userDetailsModel.username ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins Medium',
                                ),
                              ),
                              Text(
                                _.userDetailsModel.phoneNumber ?? '',
                              ),
                              Text(
                                _.userDetailsModel.address ?? '',
                                style: const TextStyle(
                                  color: greyColor,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CustomProfileButtonWidget(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            backgroundColor: greyColor.withOpacity(.1),
                            label: "Change Password",
                            onTap: () =>
                                Get.to(() => const ChangePasswordScreen()),
                          ),
                          CustomProfileButtonWidget(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            textColor: Colors.white,
                            backgroundColor: primaryColor,
                            label: "Update Profile",
                            onTap: () => Get.to(() => EditProfileScreen()),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text(
                                      'Are you sure you want to Logout ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        appController.logout();
                                        Get.offAll(() => const LoginScreen());
                                      },
                                      child: const Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.logout_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      appController.userType == "Seller"
                          ? CustomProfileVehicleWidget()
                          : CustomViewPaymentWidget(),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "You have to first Login to view your Profile",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButtonWidget(
                        title: "Login",
                        onTap: () => Get.to(
                          () => const LoginScreen(),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
