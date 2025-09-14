import 'package:flutter/material.dart';
import 'package:superapp/enums/product_fetch_data_type.enum.dart';
import 'package:superapp/models/category.dart';
import 'package:superapp/models/product.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/requests/product.request.dart';
import 'package:superapp/services/navigation.service.dart';
import 'package:superapp/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllProductsViewModel extends MyBaseViewModel {
  //
  Category? category;
  ProductFetchDataType type;
  VendorType? vendorType;
  //
  int queryPage = 1;
  ProductRequest productRequest = ProductRequest();
  List<Product> products = [];

  SeeAllProductsViewModel(
    BuildContext context, {
    required this.type,
    this.category,
    this.vendorType,
  }) {
    this.viewContext = context;
  }

  //
  startSearch({bool initialLoaoding = true}) async {
    if (isBusy || busy(products)) {
      return;
    }
    //
    if (initialLoaoding) {
      products.clear();
      queryPage = 1;
      setBusy(true);
    } else {
      setBusyForObject(products, true);
    }
    try {
      Map<String, dynamic> queryParams = {
        "category_id": category?.id,
        "vendor_type_id": vendorType?.id,
        "type": type.name.toLowerCase(),
        "filter": type.name.toLowerCase(),
        "latitude": deliveryaddress?.latitude,
        "longitude": deliveryaddress?.longitude,
      };
      final mProducts = await productRequest.getProdcuts(
        queryParams: queryParams,
        page: queryPage,
      );
      products.addAll(mProducts);
      //only increase page if not empty
      if (mProducts.isNotEmpty) {
        queryPage++;
      }
    } catch (error) {
      print("See All Fetch Products Error ==> $error");
    }
    setBusy(false);
    setBusyForObject(products, false);
  }


}
