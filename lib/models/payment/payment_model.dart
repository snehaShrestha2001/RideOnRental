class PaymentModel {
  List<PaymentHistory>? paymentHistory;
  bool? error;
  String? message;

  PaymentModel({this.paymentHistory, this.error, this.message});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    paymentHistory = json["payment_history"] == null
        ? null
        : (json["payment_history"] as List)
            .map((e) => PaymentHistory.fromJson(e))
            .toList();
    error = json["error"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentHistory != null) {
      data["payment_history"] = paymentHistory?.map((e) => e.toJson()).toList();
    }
    data["error"] = error;
    data["message"] = message;
    return data;
  }
}

class PaymentHistory {
  int? paymentId;
  int? productId;
  String? startDate;
  String? endDate;
  ProductDetails? productDetails;

  PaymentHistory(
      {this.paymentId,
      this.productId,
      this.startDate,
      this.endDate,
      this.productDetails});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    paymentId = json["payment_id"];
    productId = json["product_id"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    productDetails = json["product_details"] == null
        ? null
        : ProductDetails.fromJson(json["product_details"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["payment_id"] = paymentId;
    data["product_id"] = productId;
    data["start_date"] = startDate;
    data["end_date"] = endDate;
    if (productDetails != null) {
      data["product_details"] = productDetails?.toJson();
    }
    return data;
  }
}

class ProductDetails {
  int? productId;
  String? productName;
  int? productPrice;
  String? productDescription;
  String? productFeatures;
  String? productColor;
  String? productDuration;
  String? productType;
  String? productImage;
  String? productPriceType;
  String? productCondition;
  int? userId;
  String? seller;
  String? sellerNumber;

  ProductDetails(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productFeatures,
      this.productColor,
      this.productDuration,
      this.productType,
      this.productImage,
      this.productPriceType,
      this.productCondition,
      this.userId,
      this.seller,
      this.sellerNumber});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    productName = json["product_name"];
    productPrice = json["product_price"];
    productDescription = json["product_description"];
    productFeatures = json["product_features"];
    productColor = json["product_color"];
    productDuration = json["product_duration"];
    productType = json["product_type"];
    productImage = json["product_image"];
    productPriceType = json["product_price_type"];
    productCondition = json["product_condition"];
    userId = json["user_id"];
    seller = json["seller"];
    sellerNumber = json["seller_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["product_name"] = productName;
    data["product_price"] = productPrice;
    data["product_description"] = productDescription;
    data["product_features"] = productFeatures;
    data["product_color"] = productColor;
    data["product_duration"] = productDuration;
    data["product_type"] = productType;
    data["product_image"] = productImage;
    data["product_price_type"] = productPriceType;
    data["product_condition"] = productCondition;
    data["user_id"] = userId;
    data["seller"] = seller;
    data["seller_number"] = sellerNumber;
    return data;
  }
}
