import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_rental/constants.dart';

import '../../../controllers/app_controller.dart';
import '../../../controllers/payment/payment_controller.dart';

class CustomViewPaymentWidget extends StatelessWidget {
  CustomViewPaymentWidget({super.key});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(initState: (state) {
      if (appController.userType == "Customer") {
        Get.find<PaymentController>().getRentalHistory();
      }
    }, builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (appController.userType == "Customer") {
                Get.find<PaymentController>().getRentalHistory();
              }
            },
            child: const Text(
              "My Rental History",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _.rentalHistoryList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _.rentalHistoryList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: greyColor.withOpacity(.1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "#${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "From : ${_.rentalHistoryList[index].startDate ?? ''}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "To : ${_.rentalHistoryList[index].endDate ?? ''}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Rented Vehicle : ",
                              children: [
                                TextSpan(
                                  text: _.rentalHistoryList[index]
                                          .productDetails?.productName ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Rented Price : ",
                              children: [
                                TextSpan(
                                  text: _.rentalHistoryList[index]
                                      .productDetails?.productPrice
                                      .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Renter : ",
                              children: [
                                TextSpan(
                                  text: _.rentalHistoryList[index]
                                          .productDetails?.seller ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Renter Contact : ",
                              children: [
                                TextSpan(
                                  text: _.rentalHistoryList[index]
                                          .productDetails?.sellerNumber ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _.deleteRental(
                                paymentId: _.rentalHistoryList[index].paymentId
                                    .toString()),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Cancel Rental",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Column(
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: Text("You haven't rented any Vehicles yet")),
                  ],
                )
        ],
      );
    });
  }
}
