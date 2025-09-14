import 'package:flutter/material.dart';
import 'package:superapp/views/pages/food/model/food_model.dart';

class FoodController extends ChangeNotifier {
  List<FoodModel> _foods = myfood;

  FoodModel? _selectedFood;

  List<FoodModel> get foods => _foods;

  FoodModel? get selectedFood => _selectedFood;

  void selectFood(FoodModel food) {
    _selectedFood = food;
    notifyListeners();
  }
}
