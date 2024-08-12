import 'dart:convert';

class QrDataGetNameModel {
  bool success;
  Data data;

  QrDataGetNameModel({
    required this.success,
    required this.data,
  });

  factory QrDataGetNameModel.fromRawJson(String str) => QrDataGetNameModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrDataGetNameModel.fromJson(Map<String, dynamic> json) => QrDataGetNameModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  String firstName;
  String lastName;
  String patron;
  bool enabled;
  String name;
  bool admin;

  Data({
    required this.firstName,
    required this.lastName,
    required this.patron,
    required this.enabled,
    required this.name,
    required this.admin,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["firstName"],
    lastName: json["lastName"],
    patron: json["patron"],
    enabled: json["enabled"],
    name: json["name"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "patron": patron,
    "enabled": enabled,
    "name": name,
    "admin": admin,
  };
}
