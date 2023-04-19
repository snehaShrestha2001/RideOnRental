import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ride_with_rental/models/all_products/all_products_model.dart';

import '../../constants.dart';
import '../../models/authorization/authorization_model.dart';

class WishlistApi {
  static Future<AuthorizationModel> add({
    String? productId,
    required String apiKey,
  }) async {
    var url = '${baseUrl}wishlist';
    Map<String, String> data = {
      'product_id': productId ?? "",
    };
    final response = await http.post(Uri.parse(url), body: data, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "api_key": apiKey,
    });

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

  static Future<List<Products>> get({
    required String apiKey,
  }) async {
    var url = '${baseUrl}wishlist';

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "api_key": apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var wishlistResponse = AllProductsModel.fromJson(data).products ?? [];
      return wishlistResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<AuthorizationModel> remove({
    String? wishlistId,
    required String apiKey,
  }) async {
    var url = '${baseUrl}wishlist';
    Map<String, String> param = {
      'wishlist_id': wishlistId ?? "",
    };
    final finalParam = Uri.parse(url).replace(queryParameters: param);
    final response = await http.delete(finalParam, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "api_key": apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var authorizationResponse = AuthorizationModel.fromJson(data);
      return authorizationResponse;
    } else if (response.statusCode == 400) {
      throw Exception(response.body);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
