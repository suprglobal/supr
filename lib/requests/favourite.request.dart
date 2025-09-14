import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/models/product.dart';
import 'package:superapp/models/vendor.dart';
import 'package:superapp/services/http.service.dart';

class FavouriteRequest extends HttpService {
  //
  Future<List<Product>> favourites() async {
    final apiResult = await get(Api.favourites);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      List<Product> products = [];
      (apiResponse.body as List).forEach(
        (jsonObject) {
          try {
            products.add(Product.fromJson(jsonObject["product"]));
          } catch (error) {
            print("error: $error");
          }
        },
      );
      return products;
    }

    throw apiResponse.message!;
  }

  //
  Future<ApiResponse> makeFavourite(int id) async {
    final apiResult = await post(
      Api.favourites,
      {
        "product_id": id,
      },
    );

    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> removeFavourite(int productId) async {
    final apiResult = await delete(Api.favourites + "/$productId");
    return ApiResponse.fromResponse(apiResult);
  }

  //vendor
  Future<List<Vendor>> favouriteVendors() async {
    final apiResult = await get(Api.favouriteVendors);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      List<Vendor> dataset = [];
      (apiResponse.body as List).forEach(
        (jsonObject) {
          try {
            dataset.add(Vendor.fromJson(jsonObject["vendor"]));
          } catch (error) {
            print("error: $error");
          }
        },
      );
      return dataset;
    }

    throw apiResponse.message!;
  }

  //
  Future<ApiResponse> makeFavouriteVendor(int id) async {
    final apiResult = await post(
      Api.favouriteVendors,
      {
        "vendor_id": id,
      },
    );

    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> removeFavouriteVendor(int vendorId) async {
    final apiResult = await delete("${Api.favouriteVendors}/$vendorId");
    return ApiResponse.fromResponse(apiResult);
  }
}
