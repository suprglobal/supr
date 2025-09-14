import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/services/http.service.dart';
import 'package:superapp/views/pages/food/model/all_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/brand_model.dart';
import 'package:superapp/views/pages/food/model/category_model.dart';
import 'package:superapp/views/pages/food/model/filter_food_model.dart';
import 'package:superapp/views/pages/food/model/food_product_detail_model.dart';
import 'package:superapp/views/pages/food/model/near_by_restaurant_model.dart';
import 'package:superapp/views/pages/food/model/offer_model.dart';
import 'package:superapp/views/pages/food/model/restaurant_detail_model.dart';
import 'package:superapp/views/pages/food/model/restaurants_model.dart';
import 'package:superapp/views/pages/food/model/search-food_model.dart';

class FoodRequest extends HttpService {


  Future<TrendingRestaurantsModel> getTrendingRestaurants() async {
    final apiResult = await get("${Api.trendingRestaurants}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return TrendingRestaurantsModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<CategoryModel> getAllCategories() async {
    final apiResult = await get("${Api.allCategories}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return CategoryModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<TrendingRestaurantsModel> getBestSellersRestaurants() async {
    final apiResult = await get("${Api.bestSellerRestaurants}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return TrendingRestaurantsModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<NearbyRestaurantsModel> getNearByRestaurants() async {
    final apiResult = await get("${Api.nearbyRestaurants}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return NearbyRestaurantsModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<AllRestaurantsModel> getAllRestaurants() async {
    final apiResult = await get("${Api.allRestaurants}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return AllRestaurantsModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<OfferModel> getAllBanners() async {
    final apiResult = await get("${Api.restaurantBanners}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return OfferModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<RestaurantsDetailModel> getRestaurantDetail(String id) async {
    final apiResult = await get("${Api.restaurantDetail}/$id");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return RestaurantsDetailModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }
  Future<FoodProductDetailModel> getProductDetail(String id) async {
      final apiResult = await get("${Api.productDetail}/$id");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return FoodProductDetailModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<BrandModel> getPopularBrands() async {
    final apiResult = await get("${Api.popularBrands}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return BrandModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  Future<SearchFoodModel> getSearch(String? query) async {
    final apiResult = await get("${Api.searchFoodApi}$query");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return SearchFoodModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }

  final Map<String, dynamic> filterParamsMap = {
    "Top Rated": {"top_rated": "1"},
    "Offers": {"offers": "1"},
    "Free Delivery": {"free_delivery": "1"},
    "10 % Off": {"price_level[]": "10"},
    "20% Off": {"price_level[]": "20"},
    "30% Off": {"price_level[]": "30"},
  };

  String buildFilterQuery(List<String> selectedFilters) {
    final queryParams = <String, List<String>>{};

    for (var filter in selectedFilters) {
      final mapping = filterParamsMap[filter];
      if (mapping != null) {
        mapping.forEach((key, value) {
          queryParams.putIfAbsent(key, () => []).add(value);
        });
      }
    }

    return queryParams.entries.map((e) {
      if (e.value.length == 1) {
        return "${e.key}=${e.value.first}";
      } else {
        return e.value.map((v) => "${e.key}=$v").join("&");
      }
    }).join("&");
  }


  Future<FilterFoodModel> getFilter(
      List<String> selectedFilters, {
        String sortBy = "recommended",
      })
  async {
    final queryParams = <String, dynamic>{};
    final List<String> priceLevels = [];

    if (selectedFilters.contains("Top Rated")) {
      queryParams["top_rated"] = "1";
    }
    if (selectedFilters.contains("Offers")) {
      queryParams["offers"] = "1";
    }
    if (selectedFilters.contains("Free Delivery")) {
      queryParams["free_delivery"] = "1";
    }
    if (selectedFilters.contains("10% Off")) {
      priceLevels.add("10");
    }
    if (selectedFilters.contains("20% Off")) {
      priceLevels.add("20");
    }
    if (selectedFilters.contains("30% Off")) {
      priceLevels.add("30");
    }

    if (priceLevels.isNotEmpty) {
      queryParams["price_level[]"] = priceLevels;
    }
    queryParams["sort_by"] = sortBy;

    final uri = Uri.parse(Api.filterFoodApi).replace(
      queryParameters: queryParams.map(
            (key, value) => MapEntry(
          key,
          value is List ? value.join(",") : value.toString(),
        ),
      ),
    );


    final apiResult = await get(uri.toString());
    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return FilterFoodModel.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message!;
    }
  }


}
