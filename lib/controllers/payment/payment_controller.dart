import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:ride_with_rental/api/payment/payment_api.dart';
import 'package:ride_with_rental/models/payment/payment_model.dart';
import 'package:ride_with_rental/screens/payment/payment_success_screen.dart';

import '../app_controller.dart';

class PaymentController extends GetxController {
  var rentalHistoryList = <PaymentHistory>[];
  var appController = Get.find<AppController>();
  String errorMessage = "";

  Future checkout({
    required var context,
    required int payAmout,
    int? productId,
    String? productName,
  }) async {
    // we cannot send more than 200 rupees in Khalti
    var amount = 0;
    if ((payAmout / 100) > 200) {
      amount = 199;
    }
    amount = payAmout;

    // getting the current date and time to show the payment date & time
    DateTime now = DateTime.now();

    var appController = Get.find<AppController>();
    String apiKey = appController.apiKey;

    DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
    ).then((value) {
      String startDate =
          DateFormat('y-MM-d').format(value?.start ?? DateTime.now());
      String endDate =
          DateFormat('y-MM-d').format(value?.end ?? DateTime.now());

      if (value != null) {
        final config = PaymentConfig(
          amount: amount, // Amount should be in paisa
          productIdentity: productId.toString(),
          productName: productName ?? '',
        );
        KhaltiScope.of(context).pay(
          config: config,
          preferences: const [
            // Not providing this will enable all the payment methods.
            PaymentPreference.khalti,
          ],
          onSuccess: (successModel) async {
            // Perform Server Verification
            try {
              var response = await PaymentApi.payment(
                apiKey: apiKey,
                productId: productId.toString(),
                startDate: startDate,
                endDate: endDate,
              );

              if (response.error != null && response.error == false) {
                Get.offAll(() => const PaymentSucessScreen());
              } else {
                Get.rawSnackbar(
                  message: response.message,
                  duration: const Duration(seconds: 1),
                );
              }
            } catch (e) {
              String errorMessage;
              if (e.toString().contains("SocketException")) {
                errorMessage = "No Internet Connection";
              } else {
                errorMessage = e.toString();
              }
              Get.rawSnackbar(
                message: errorMessage,
                duration: const Duration(seconds: 1),
              );
            }
          },
          onFailure: (failureModel) {
            // What to do on failure?
            Get.rawSnackbar(
              message: failureModel.message,
              duration: const Duration(seconds: 1),
            );
          },
          onCancel: () {
            // User manually cancelled the transaction
          },
        );
      }

      return;
    });
  }

  Future<void> getRentalHistory() async {
    try {
      rentalHistoryList = await PaymentApi.getRentalHistory(
        apiKey: appController.apiKey,
      );
      update();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = "Failed to load Rental history";
      }
      errorMessage = e.toString();
    }
  }

  Future<void> deleteRental({String? paymentId}) async {
    try {
      var response = await PaymentApi.deleteRental(
        apiKey: appController.apiKey,
        paymentId: paymentId ?? '',
      );

      if (response.error == false) {
        rentalHistoryList.removeWhere(
            (element) => element.paymentId.toString() == paymentId);
        Get.rawSnackbar(
            message: "Rental Cancelled Successfully",
            duration: const Duration(seconds: 1));
      }
      update();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = "Failed to delete Rental";
      }
      errorMessage = e.toString();
    }
  }
}
