class AllProductsModel {
  List<Products>? products;
  bool? error;
  String? message;

  AllProductsModel({this.products, this.error, this.message});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
    products = json["products"] == null
        ? null
        : (json["products"] as List).map((e) => Products.fromJson(e)).toList();
    error = json["error"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data["products"] = products?.map((e) => e.toJson()).toList();
    }
    data["error"] = error;
    data["message"] = message;
    return data;
  }
}

class Products {
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
  int? wishlistId;
  String? seller;
  String? sellerPhnNum;
  String? status;

  Products({
    this.productId,
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
    this.sellerPhnNum,
    this.wishlistId,
    this.status,
  });

  Products.fromJson(Map<String, dynamic> json) {
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
    sellerPhnNum = json["seller_number"];
    wishlistId = json["wishlist_id"];
    status = json["status"];
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
    data["wishlist_id"] = wishlistId;
    data["status"] = status;
    return data;
  }
}
