import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  SharedPreferences sharedPreferences;
  var isLoggedIn = false;
  // String? username, password, phoneNumber, address;

  AppController(this.sharedPreferences) {
    String? apiKey = sharedPreferences.getString('apiKey');

    if (apiKey == null || apiKey == "") {
      isLoggedIn = false; //isLoggedIn = =true;
    } else {
      isLoggedIn = true;
    }
  }

  String get apiKey => sharedPreferences.getString("apiKey") ?? "";
  String get userType => sharedPreferences.getString("userType") ?? "";

  void logout() async {
    await sharedPreferences.remove("userId");
    await sharedPreferences.remove("apiKey");
    await sharedPreferences.remove("userType");
  }
}
