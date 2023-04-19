import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:ride_with_rental/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ride_with_rental/models/all_products/all_products_model.dart';
import 'package:http_parser/http_parser.dart';

import '../../models/authorization/authorization_model.dart';

class ProductApi {
  static Future<List<Products>> getAllProducts() async {
    var url = "${baseUrl}get-all-products";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var allProductsResponse = AllProductsModel.fromJson(data).products;
      return allProductsResponse ?? [];
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<AuthorizationModel> uploadProduct({
    String? name,
    String? price,
    String? description,
    String? features,
    String? color,
    String? duration,
    String? type,
    XFile? imageFile,
    String? priceType,
    String? condition,
    required String apiKey,
  }) async {
    var url = '${baseUrl}upload-product';

    Map<String, String> payload = {
      'name': name ?? "",
      'price': price ?? "",
      'description': description ?? "",
      'features': features ?? "",
      'color': color ?? "",
      'duration': duration ?? "",
      'type': type ?? "",
      'price_type': priceType ?? "",
      'condition': condition ?? "",
    };
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Content-Type": "application/form-data",
      "api_key": apiKey,
    });

    print(request);

    imageFile == null
        ? null
        : request.files.add(
            await http.MultipartFile.fromPath(
              "image",
              imageFile.path,
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
      throw Exception(response.body);
    }
  }

  static Future<List<Products>> getSellerProduct({
    required String apiKey,
  }) async {
    var url = "${baseUrl}get-seller-product";

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "api_key": apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var singleProductResponse = AllProductsModel.fromJson(data).products;
      return singleProductResponse ?? [];
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }
}
