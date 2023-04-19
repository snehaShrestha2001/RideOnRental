import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:ride_with_rental/controllers/authorization/authorization_controller.dart';
import 'package:ride_with_rental/controllers/payment/payment_controller.dart';
import 'package:ride_with_rental/controllers/profile/profile_controller.dart';
import 'package:ride_with_rental/controllers/wishlist/wishlist_controller.dart';
import 'package:ride_with_rental/controllers/filter_data/filter_data_controller.dart';
import 'package:ride_with_rental/controllers/product/product_controller.dart';
import 'package:ride_with_rental/controllers/single_item/single_item_controller.dart';
import 'package:ride_with_rental/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPref = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPref));
}

class MyApp extends StatelessWidget {
  SharedPreferences sharedPreferences;
  MyApp(this.sharedPreferences, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_bd9293470a5542b1bdcaf7dc71fef34b',
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            title: 'Ride with Rental',
            debugShowCheckedModeBanner: false,

            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],

            // setting theme color and font
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: primaryColor,
              ),
              fontFamily: 'Poppins Regular',
            ),
            initialBinding: BindingsBuilder(
              () {
                Get.put(AppController(sharedPreferences), permanent: true);
                Get.put(ProductController());
                Get.put(FilterDataController());
                Get.put(AuthorizationController());
                Get.put(SingleItemController());
                Get.put(WishlistController());
                Get.put(PaymentController());
                Get.put(ProfileController());
              },
            ),
            home: const HomeScreen(),
          );
        });
  }
}
