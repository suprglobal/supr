import 'dart:convert';

import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';

class FilterFoodModel {
  final bool? success;
  final Data? data;

  FilterFoodModel({
    this.success,
    this.data,
  });

  factory FilterFoodModel.fromRawJson(String str) => FilterFoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterFoodModel.fromJson(Map<String, dynamic> json) => FilterFoodModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  final List<RestaurantsModel>? restaurants;
  final int? total;

  Data({
    this.restaurants,
    this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    restaurants: json["restaurants"] == null ? [] : List<RestaurantsModel>.from(json["restaurants"]!.map((x) => RestaurantsModel.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    "total": total,
  };
}

