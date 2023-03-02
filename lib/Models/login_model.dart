import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  List<String> message;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: List<String>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.name,
    required this.phone,
    required this.token,
    required this.otp,
  });

  String name;
  String phone;
  String token;
  String otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    phone: json["phone"],
    token: json["token"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "token": token,
    "otp": otp,
  };
}
