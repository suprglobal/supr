import 'dart:convert';

import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';

class TrendingRestaurantsModel {
  final bool? success;
  final List<RestaurantsModel>? data;
  final String? message;

  TrendingRestaurantsModel({
    this.success,
    this.data,
    this.message,
  });

  factory TrendingRestaurantsModel.fromRawJson(String str) => TrendingRestaurantsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrendingRestaurantsModel.fromJson(Map<String, dynamic> json) => TrendingRestaurantsModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<RestaurantsModel>.from(json["data"]!.map((x) => RestaurantsModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}


