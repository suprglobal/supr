import 'dart:convert';

import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';

class NearbyRestaurantsModel {
  final bool? success;
  final Data? data;
  final String? message;

  NearbyRestaurantsModel({
    this.success,
    this.data,
    this.message,
  });

  factory NearbyRestaurantsModel.fromRawJson(String str) => NearbyRestaurantsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NearbyRestaurantsModel.fromJson(Map<String, dynamic> json) => NearbyRestaurantsModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final List<RestaurantsModel>? restaurants;
  final SearchLocation? searchLocation;
  final int? totalFound;

  Data({
    this.restaurants,
    this.searchLocation,
    this.totalFound,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    restaurants: json["restaurants"] == null ? [] : List<RestaurantsModel>.from(json["restaurants"]!.map((x) => RestaurantsModel.fromJson(x))),
    searchLocation: json["search_location"] == null ? null : SearchLocation.fromJson(json["search_location"]),
    totalFound: json["total_found"],
  );

  Map<String, dynamic> toJson() => {
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    "search_location": searchLocation?.toJson(),
    "total_found": totalFound,
  };
}



class SearchLocation {
  final String? latitude;
  final String? longitude;
  final int? radiusKm;

  SearchLocation({
    this.latitude,
    this.longitude,
    this.radiusKm,
  });

  factory SearchLocation.fromRawJson(String str) => SearchLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchLocation.fromJson(Map<String, dynamic> json) => SearchLocation(
    latitude: json["latitude"],
    longitude: json["longitude"],
    radiusKm: json["radius_km"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "radius_km": radiusKm,
  };
}
