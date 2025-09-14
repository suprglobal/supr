import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/brand_model.dart';
import 'package:superapp/views/pages/food/model/category_model.dart';
import 'package:superapp/views/pages/food/model/filter_food_model.dart';
import 'package:superapp/views/pages/food/model/near_by_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/offer_model.dart';
import 'package:superapp/views/pages/food/model/restaurants_model.dart';
import 'package:superapp/views/pages/food/model/search-food_model.dart';
import 'package:superapp/views/pages/food/service/food_api_services.dart';

class FoodRestaurantController extends GetxController {
  var trendingRestaurants = <RestaurantsModel>[].obs;
  var categoryRecord = <CategoryRecord>[].obs;
  var bestSellerRestaurants = <RestaurantsModel>[].obs;
  var nearByRestaurants = <RestaurantsModel>[].obs;
  var allRestaurants = <RestaurantsModel>[].obs;
  var popularBrandRecords = <BrandDetailRecord>[].obs;
  var offerRecords = <OfferRecord>[].obs;
  var isTrendingLoading = false.obs;
  var isCategory = false.obs;
  var isPopularBrandsLoading = false.obs;
  var isBestSellerLoading = false.obs;
  var isNearByLoading = false.obs;
  var isAllLoading = false.obs;
  var isBannerLoading = false.obs;

  final FoodRequest foodRequest = FoodRequest();

  @override
  void onInit() {
    fetchAllBanners();
    fetchAllCategories();
    fetchTopTrendingRestaurants();
    fetchPopularBrands();
    fetchBestSellersRestaurants();
    fetchNearByRestaurants();
    fetchAllRestaurants();
    super.onInit();
  }

  Future<void> fetchTopTrendingRestaurants() async {
    try {
      isTrendingLoading(true);
      TrendingRestaurantsModel response = await foodRequest.getTrendingRestaurants();
      if(response.success == true){
          trendingRestaurants.value = response.data ?? [];
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
        debugPrint("Error ${e}");
      } finally {
        isTrendingLoading(false);
      }
    }

  Future<void> fetchAllCategories() async {
    try {
      isCategory(true);
      CategoryModel response = await foodRequest.getAllCategories();
      if(response.success == true){
        categoryRecord.value = response.data?.data ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isCategory(false);
    }
  }
    Future<void> fetchBestSellersRestaurants() async {
      try {
        isBestSellerLoading(true);
        TrendingRestaurantsModel response = await foodRequest.getBestSellersRestaurants();
        if(response.success == true){
        bestSellerRestaurants.value = response.data ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isBestSellerLoading(false);
    }
  }
  Future<void> fetchNearByRestaurants() async {
    try {
      isNearByLoading(true);
      NearbyRestaurantsModel response = await foodRequest.getNearByRestaurants();
      if(response.success == true){
        nearByRestaurants.value = response.data?.restaurants ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isNearByLoading(false);
    }
  }
  Future<void> fetchAllRestaurants() async {
    try {
      isAllLoading(true);
      AllRestaurantsModel response = await foodRequest.getAllRestaurants();
      if(response.success == true){
        allRestaurants.value = response.data?.data ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isAllLoading(false);
    }
  }
  Future<void> fetchAllBanners() async {
    try {
      isBannerLoading(true);
      OfferModel response = await foodRequest.getAllBanners();
      if(response.success == true){
        offerRecords.value = response.data?.data ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isBannerLoading(false);
    }
  }
  Future<void> fetchPopularBrands() async {
    try {
      isPopularBrandsLoading(true);
      BrandModel response = await foodRequest.getPopularBrands();
      if(response.status == true){
        popularBrandRecords.value = response.data ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isPopularBrandsLoading(false);
    }
  }



}
