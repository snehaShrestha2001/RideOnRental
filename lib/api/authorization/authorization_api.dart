import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ride_with_rental/models/authorization/authorization_model.dart';

import '../../controllers/app_controller.dart';
import 'package:http_parser/http_parser.dart';

class AuthorizationApi {
  static final controller = Get.find<AppController>();

  static Future<AuthorizationModel> login(
    String phnNum,
    String password,
  ) async {
    var url = '${baseUrl}login';
    Map<String, String> data = {
      'phoneNumber': phnNum,
      'password': password,
    };
    final response = await http.post(Uri.parse(url), body: data, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      setUserDetails(authorizationResponse);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static setUserDetails(AuthorizationModel model) async {
    await controller.sharedPreferences
        .setString("userId", model.userId.toString());
    await controller.sharedPreferences.setString("apiKey", model.apiKey ?? '');
    await controller.sharedPreferences
        .setString("userType", model.userType ?? '');
  }

  static Future<AuthorizationModel> register({
    required String phnNum,
    required String password,
    required String name,
    required String address,
    required String userType,
  }) async {
    var url = '${baseUrl}register';
    Map<String, String> data = {
      'name': name,
      'phoneNumber': phnNum,
      'password': password,
      'address': address,
      'userType': userType,
    };
    final response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );
    //
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<AuthorizationModel> getUserDetails({String? apiKey}) async {
    var url = "${baseUrl}user-details";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "api_key": apiKey ?? "",
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      print(authorizationResponse.username);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<AuthorizationModel> updateProfile({
    String? updateName,
    String? updatePhnNum,
    String? updateAddress,
    XFile? updateProfilePic,
  }) async {
    var url = '${baseUrl}edit-profile';

    Map<String, String> payload = {
      'name': updateName ?? '',
      'phnNum': updatePhnNum ?? '',
      'address': updateAddress ?? '',
    };

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Content-Type": "application/form-data",
      "api_key": controller.apiKey,
    });

    updateProfilePic == null
        ? null
        : request.files.add(
            await http.MultipartFile.fromPath(
              "image",
              updateProfilePic.path,
              contentType: MediaType(
                'image',
                'jpg',
              ),
            ),
          );

    request.fields.addAll(payload);
    var data = await request.send();
    var response = await http.Response.fromStream(data);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception(controller.apiKey);
    }
  }

  static Future<AuthorizationModel> changePassword({
    String? newPassword,
    String? apiKey,
  }) async {
    var url = '${baseUrl}change-password';
    Map<String, String> data = {
      'password': newPassword ?? '',
    };
    final response = await http.put(
      Uri.parse(url),
      body: data,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "api_key": apiKey ?? "",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }
}
