import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/views/pages/food/model/search-food_model.dart';
import 'package:superapp/views/pages/food/service/food_api_services.dart';

class SearchFoodController extends GetxController {
  var searchFoodModel = Rxn<SearchFoodModel>();
  var isLoading = false.obs;
  var isRestaurantSelected = true.obs;


  final FoodRequest foodRequest = FoodRequest();

  Future<void> searchRestaurantDishes(String? query) async {
    try {
      isLoading(true);
      SearchFoodModel response = await foodRequest.getSearch(query);
      if(response.success == true){
        searchFoodModel.value = response;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isLoading(false);
    }
  }




}
