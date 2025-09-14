import 'dart:async';

import 'package:flutter/material.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/requests/vendor_type.request.dart';
import 'package:superapp/services/auth.service.dart';
import 'package:superapp/services/location.service.dart';
import 'package:superapp/view_models/base.view_model.dart';

class WelcomeViewModel extends MyBaseViewModel {
  //
  WelcomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  Widget? selectedPage;
  List<VendorType> vendorTypes = [];
  VendorTypeRequest vendorTypeRequest = VendorTypeRequest();
  bool showGrid = true;
  StreamSubscription? authStateSub;
  bool _isInitialised = false;

  //
  //
  initialise({bool initial = true}) async {
    //
    if (_isInitialised) return;
    _isInitialised = true;

    preloadDeliveryLocation();
    //
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }

    if (!initial) {
      pageKey = GlobalKey();
      notifyListeners();
    }

    print('test');
    await getVendorTypes();
    listenToAuth();
    //
    handleLocationStream();
  }

  StreamSubscription? currentLocSub;
  StreamSubscription? currentLoc2Sub;
  handleLocationStream() async {
    await currentLocSub?.cancel();
    currentLocSub = LocationService.currenctDeliveryAddressSubject
        .skipWhile((_) => true)
        .listen(
      (event) {
        initialise(initial: false);
      },
    );

    await currentLoc2Sub?.cancel();
    currentLoc2Sub = LocationService.currenctDeliveryAddressSubject.stream
        .skipWhile((_) => true)
        .listen((event) {
      initialise(initial: false);
    });
  }

  listenToAuth() {
    authStateSub = AuthServices.listenToAuthState().listen((event) {
      genKey = GlobalKey();
      notifyListeners();
    });
  }

  getVendorTypes() async {
    setBusy(true);
    try {
      print("VENDOR TYPES: ${vendorTypes.length}");

      vendorTypes = await vendorTypeRequest.index();
      print("VENDOR TYPES: ${vendorTypes.length}");
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

}
