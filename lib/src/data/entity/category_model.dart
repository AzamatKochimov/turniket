// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';



CategoryData categoryModelFromJson(String str) => CategoryData.fromJson(json.decode(str));

String categoryModelToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  final bool status;
  final List<CategoryModel> categories;

  CategoryData({
    required this.status,
    required this.categories,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    status: json["status"],
    categories: List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
