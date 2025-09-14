
import 'package:flutter/material.dart';
import 'package:superapp/extensions/context.dart';
import 'package:superapp/models/product.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/services/auth.service.dart';
import 'package:superapp/views/pages/auth/login.page.dart';
import 'package:superapp/views/pages/taxi/taxi.page.dart';
import 'package:velocity_x/velocity_x.dart';

class NavigationService {
  static pageSelected(
    VendorType vendorType, {
    required BuildContext context,
    bool loadNext = true,
  }) async {
    Widget nextpage = vendorTypePage(
      vendorType,
      context: context,
    );

    //
    if (vendorType.authRequired && !AuthServices.authenticated()) {
      final result = await context.push(
        (context) => LoginPage(
          required: true,
        ),
      );
      //
      if (result == null || !result) {
        return;
      }
    }
    //
    if (loadNext) {
      context.nextPage(nextpage);
    }
  }

  static Widget vendorTypePage(
    VendorType vendorType, {
    required BuildContext context,
  }) {
    Widget homeView;
    homeView = TaxiPage(vendorType: vendorType);


    return homeView;
  }




}
