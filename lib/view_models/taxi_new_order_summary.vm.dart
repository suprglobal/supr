import 'package:flutter/material.dart';
import 'package:superapp/constants/app_ui_sizes.dart';
import 'package:superapp/models/coupon.dart';
import 'package:superapp/requests/taxi.request.dart';
import 'package:superapp/services/geocoder.service.dart';
import 'package:superapp/view_models/base.view_model.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/views/pages/taxi/apply_discount.page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superapp/extensions/context.dart';

class NewTaxiOrderSummaryViewModel extends MyBaseViewModel {
  //
  NewTaxiOrderSummaryViewModel(BuildContext context, this.taxiViewModel) {
    this.viewContext = context;
  }

  TaxiRequest taxiRequest = TaxiRequest();
  GeocoderService geocoderService = GeocoderService();
  final TaxiViewModel taxiViewModel;
  PanelController panelController = PanelController();
  double customViewHeight = AppUISizes.taxiNewOrderSummaryHeight;

  initialise() {}

  //
  updateLoadingheight() {
    customViewHeight = AppUISizes.taxiNewOrderHistoryHeight;
    notifyListeners();
  }

  resetStateViewheight([double height = 0]) {
    customViewHeight = AppUISizes.taxiNewOrderIdleHeight + height;
    notifyListeners();
  }

  closePanel() async {
    clearFocus();
    await panelController.close();
    notifyListeners();
  }

  clearFocus() {
    FocusScope.of(taxiViewModel.viewContext).requestFocus(new FocusNode());
  }

  openPanel() async {
    await panelController.open();
    notifyListeners();
  }



  void openCoupnDialog() async {
    //
    final result = await Navigator.of(viewContext).push(
      MaterialPageRoute(
        builder: (context) => ApplyDiscountPage(
          coupon: taxiViewModel.coupon,
        ),
      ),
    );
    //
    if (result != null && result is Coupon) {
      this.taxiViewModel.coupon = result;
      this.taxiViewModel.calculateTotalAmount();
    } else if (result != null && result is bool && result == false) {
      this.taxiViewModel.coupon = null;
      this.taxiViewModel.calculateTotalAmount();
    }
  }
}
