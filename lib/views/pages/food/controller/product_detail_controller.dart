import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/food_product_detail_model.dart';
import 'package:superapp/views/pages/food/model/product_detail_model.dart';
import 'package:superapp/views/pages/food/model/restaurant_detail_model.dart';
import 'package:superapp/views/pages/food/model/restaurants_model.dart';
import 'package:superapp/views/pages/food/service/food_api_services.dart';

class  ProductDetailController extends GetxController {
  var productDetailRecord = Rxn<FoodProductDetailRecord>();
  var isLoading = false.obs;
  
  // Food item state
  var selectedIndex = Rxn<int>();
  var quantity = 1.obs;

  final FoodRequest foodRequest = FoodRequest();

  Future<void> fetchProductDetail(String id) async {
    try {
      isLoading(true);
      FoodProductDetailModel response = await foodRequest.getProductDetail(id);
      if(response.success == true){
        productDetailRecord.value = response.data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("Error ${e}");
    } finally {
      isLoading(false);
    }
  }

  // Food item methods
  void selectCombo(int index) {
    selectedIndex.value = index;
  }

  void increaseQty() {
    quantity.value++;
  }

  void decreaseQty() {
    if (quantity.value > 0) quantity.value--;
  }
}
