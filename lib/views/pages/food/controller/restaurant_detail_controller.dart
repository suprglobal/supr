import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/restaurant_detail_model.dart';
import 'package:superapp/views/pages/food/model/restaurants_model.dart';
import 'package:superapp/views/pages/food/service/food_api_services.dart';

class RestaurantsDetailController extends GetxController {
  var restaurantDetailRecord = Rxn<RestaurantsDetailRecord>();
  var isLoading = false.obs;

  final FoodRequest foodRequest = FoodRequest();

  Future<void> fetchRestaurantsDetails(String id) async {
    try {
      isLoading(true);
      RestaurantsDetailModel response = await foodRequest.getRestaurantDetail(id);
      if(response.success == true){
        restaurantDetailRecord.value = response.data;
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isLoading(false);
    }
  }




}
