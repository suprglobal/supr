import 'dart:developer';

import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/models/category.dart';
import 'package:superapp/services/http.service.dart';

class CategoryRequest extends HttpService {
  //
  Future<List<Category>> categories({
    int? vendorTypeId,
    int? page,
  }) async {
    final params = {
      "vendor_type_id": vendorTypeId,
      "page": page,
      "full": page == null ? 1 : 0,
    };
    log("para ${params}");
    final apiResult = await get(
      Api.categories,
      queryParameters: params,
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return (apiResponse.data)
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    } else {
      throw apiResponse.message!;
    }
  }

  Future<List<Category>> subcategories({
    int? categoryId,
    int? page,
  }) async {
    final apiResult = await get(
      //
      Api.categories,
      queryParameters: {
        "category_id": categoryId,
        "page": page,
        "type": "sub",
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    } else {
      throw apiResponse.message!;
    }
  }
}
