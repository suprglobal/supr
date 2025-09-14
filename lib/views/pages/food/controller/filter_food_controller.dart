import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/filter_food_model.dart';
import 'package:superapp/views/pages/food/model/search-food_model.dart';
import 'package:superapp/views/pages/food/service/food_api_services.dart';

class FilterFoodController extends GetxController {
  var isLoading = false.obs;
  var restaurants = <RestaurantsModel>[].obs;

  var selectedFilters = <String>["Top Rated"].obs;
  var selectedSort = "Recommended".obs;


  final  filters = ['Top Rated', 'Offers', 'Free Delivery',    '10% Off',
    '20% Off',
    '30% Off'];

  final List<String> sortOptions = [
    "Recommended",
    "Top Rated",
    "Delivery Time",
    "Cost: low to high",
    "Cost: high to low",
    "Most Popular",
  ];

  final Map<String, String> sortQueryMap = {
    "Recommended": "recommended",
    "Top Rated": "top_rated",
    "Delivery Time": "delivery_time",
    "Cost: low to high": "cost_low to_high",
    "Cost: high to low": "cost_high_to_low",
    "Most Popular": "most_popular",
  };



  final FoodRequest foodRequest = FoodRequest();


  Future<void> filterFood() async {
    try {
      isLoading(true);
      final sortParam = sortQueryMap[selectedSort.value] ?? "recommended";

      FilterFoodModel response = await foodRequest.getFilter(selectedFilters,
        sortBy: sortParam,

      );
      if(response.success == true){
        restaurants.value = response.data?.restaurants ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isLoading(false);
    }
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    filterFood(); // refresh API after change
  }
  void setSort(String option) {
    selectedSort.value = option;
    filterFood();
  }

}
