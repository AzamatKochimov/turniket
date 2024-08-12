import 'dart:convert';

class QrDataModel {
  String qrData;
  int dateTime;
  String status;
  String photoId;

  QrDataModel({
    required this.qrData,
    required this.dateTime,
    required this.status,
    required this.photoId,
  });

  factory QrDataModel.fromRawJson(String str) => QrDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrDataModel.fromJson(Map<String, dynamic> json) => QrDataModel(
    qrData: json["qrData"],
    dateTime: json["dateTime"],
    status: json["status"],
    photoId: json["photoId"],
  );

  Map<String, dynamic> toJson() => {
    "qrData": qrData,
    "dateTime": dateTime,
    "status": status,
    "photoId": photoId,
  };
}
