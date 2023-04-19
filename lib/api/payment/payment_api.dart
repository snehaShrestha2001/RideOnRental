import 'dart:convert';

import 'package:ride_with_rental/models/payment/payment_model.dart';

import '../../constants.dart';
import '../../models/authorization/authorization_model.dart';
import 'package:http/http.dart' as http;

class PaymentApi {
  static Future<AuthorizationModel> payment({
    String? productId,
    String? startDate,
    String? endDate,
    required String apiKey,
  }) async {
    var url = '${baseUrl}payment';
    Map<String, String> data = {
      'product_id': productId ?? "",
      'startDate': startDate ?? "",
      'endDate': endDate ?? "",
    };

    final response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "api_key": apiKey,
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

  static Future<List<PaymentHistory>> getRentalHistory({
    required String apiKey,
  }) async {
    var url = "${baseUrl}payment";

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "api_key": apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var paymentHistoryResponse = PaymentModel.fromJson(data).paymentHistory;
      return paymentHistoryResponse ?? [];
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<AuthorizationModel> deleteRental({
    required String apiKey,
    required String paymentId,
  }) async {
    var url = "${baseUrl}payment";

    Map<String, String> qParams = <String, String>{
      'paymentId': paymentId.toString(),
    };

    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: qParams); //USE THIS

    final response = await http.delete(finalUri, headers: {
      "api_key": apiKey,
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var paymentDeleteResponse = AuthorizationModel.fromJson(data);
      return paymentDeleteResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Some of the fields are missing');
    } else {
      throw Exception("Something went wrong");
    }
  }
}
