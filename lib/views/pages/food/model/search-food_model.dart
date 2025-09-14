import 'dart:convert';

import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';

class SearchFoodModel {
  final bool? success;
  final String? message;
  final Data? data;

  SearchFoodModel({
    this.success,
    this.message,
    this.data,
  });

  factory SearchFoodModel.fromRawJson(String str) => SearchFoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFoodModel.fromJson(Map<String, dynamic> json) => SearchFoodModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<RestaurantsModel>? restaurants;
  final List<Product>? dishes;
  final int? totalRestaurants;
  final int? totalDishes;
  final String? searchQuery;

  Data({
    this.restaurants,
    this.dishes,
    this.totalRestaurants,
    this.totalDishes,
    this.searchQuery,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    restaurants: json["restaurants"] == null ? [] : List<RestaurantsModel>.from(json["restaurants"]!.map((x) => RestaurantsModel.fromJson(x))),
    dishes: json["dishes"] == null ? [] : List<Product>.from(json["dishes"]!.map((x) => Product.fromJson(x))),
    totalRestaurants: json["total_restaurants"],
    totalDishes: json["total_dishes"],
    searchQuery: json["search_query"],
  );

  Map<String, dynamic> toJson() => {
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    "dishes": dishes == null ? [] : List<dynamic>.from(dishes!.map((x) => x.toJson())),
    "total_restaurants": totalRestaurants,
    "total_dishes": totalDishes,
    "search_query": searchQuery,
  };
}


