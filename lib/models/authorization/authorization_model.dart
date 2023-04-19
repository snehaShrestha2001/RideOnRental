class AuthorizationModel {
  bool? error;
  int? userId;
  String? username;
  String? phoneNumber;
  String? address;
  String? password;
  String? apiKey;
  String? message;
  String? userType;
  String? profilePic;

  AuthorizationModel({
    this.error,
    this.userId,
    this.username,
    this.phoneNumber,
    this.address,
    this.password,
    this.apiKey,
    this.userType,
    this.profilePic,
  });

  AuthorizationModel.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    userId = json["userId"];
    username = json["username"];
    phoneNumber = json["phoneNumber"];
    address = json["address"];
    password = json["password"];
    apiKey = json["api_key"];
    message = json["message"];
    userType = json["userType"];
    profilePic = json["profilePic"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["error"] = error;
    data["userId"] = userId;
    data["username"] = username;
    data["phoneNumber"] = phoneNumber;
    data["address"] = address;
    data["password"] = password;
    data["api_key"] = apiKey;
    data["message"] = message;
    data["userType"] = userType;
    data["profilePic"] = profilePic;
    return data;
  }
}
