import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:superapp/constants/api.dart';
import 'package:superapp/constants/app_routes.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/context.dart';
import 'package:superapp/models/cart.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/models/product.dart';
import 'package:superapp/models/vendor.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/services/alert.service.dart';
import 'package:superapp/services/auth.service.dart';
import 'package:superapp/services/cart.service.dart';
import 'package:superapp/services/cart_ui.service.dart';
import 'package:superapp/services/geocoder.service.dart';
import 'package:superapp/services/location.service.dart';
import 'package:superapp/services/toast.service.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/view_models/payment.view_model.dart';
import 'package:superapp/views/pages/auth/login.page.dart';
import 'package:superapp/widgets/bottomsheets/delivery_address_picker.bottomsheet.dart';
import 'package:velocity_x/velocity_x.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  late BuildContext viewContext;
  GlobalKey pageKey = GlobalKey<State>();
  final formKey = GlobalKey<FormState>();
  final formBuilderKey = GlobalKey<FormBuilderState>();
  GlobalKey genKey = GlobalKey();
  final currencySymbol = AppStrings.currencySymbol;
  DeliveryAddress? deliveryaddress = DeliveryAddress();
  String? firebaseVerificationId;
  VendorType? vendorType;
  Vendor? vendor;
  RefreshController refreshController = RefreshController();

  void initialise() {}

  void reloadPage() {
    pageKey = new GlobalKey<State>();
    refreshController = new RefreshController();
    notifyListeners();
    initialise();
  }

  openWebpageLink(String url) async {
    PaymentViewModel paymentViewModel = PaymentViewModel();
    paymentViewModel.viewContext = viewContext;
    await paymentViewModel.openWebpageLink(url);
  }

  //
  //open delivery address picker
  void pickDeliveryAddress({
    bool vendorCheckRequired = true,
    Function? onselected,
  }) {
    //
    showModalBottomSheet(
      context: viewContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DeliveryAddressPicker(
          vendorCheckRequired: vendorCheckRequired,
          allowOnMap: true,
          onSelectDeliveryAddress: (mDeliveryaddress) async {
            print("called here");
            viewContext.pop();
            deliveryaddress = mDeliveryaddress;
            await LocationService.saveSelectedAddressLocally(mDeliveryaddress);
            notifyListeners();

            //
            final address = Address(
              coordinates: Coordinates(
                deliveryaddress?.latitude ?? 0.00,
                deliveryaddress?.longitude ?? 0.00,
              ),
              addressLine: deliveryaddress?.address,
            );
            //
            LocationService.currenctAddress = address;
            //
            LocationService.currenctAddressSubject.sink.add(address);

            //
            if (onselected != null) onselected();
          },
        );
      },
    );
  }

  //
  bool isAuthenticated() {
    return AuthServices.authenticated();
  }

  //
  void openLogin() async {
    viewContext.nextPage(LoginPage());
    notifyListeners();
  }

  openTerms() {
    final url = Api.terms;
    openWebpageLink(url);
  }

  openPaymentTerms() {
    final url = Api.paymentTerms;
    openWebpageLink(url);
  }

  //
  //
  Future<DeliveryAddress?> showDeliveryAddressPicker() async {
    //
    DeliveryAddress? selectedDeliveryAddress;

    //
    await showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeliveryAddressPicker(
          onSelectDeliveryAddress: (deliveryAddress) {
            viewContext.pop();
            selectedDeliveryAddress = deliveryAddress;
          },
        );
      },
    );

    return selectedDeliveryAddress;
  }

  //
  Future<DeliveryAddress> getLocationCityName(
    DeliveryAddress deliveryAddress,
  ) async {
    final coordinates = new Coordinates(
      deliveryAddress.latitude ?? 0.00,
      deliveryAddress.longitude ?? 0.00,
    );
    final addresses = await GeocoderService().findAddressesFromCoordinates(
      coordinates,
    );
    //loop through the addresses and get data
    for (var address in addresses) {
      //address
      deliveryAddress.address ??= address.addressLine;
      //name
      deliveryAddress.name ??= address.featureName;
      if (deliveryAddress.name == null || deliveryAddress.name!.isEmpty) {
        deliveryAddress.name = address.addressLine;
      }
      //city
      deliveryAddress.city ??= address.locality;
      if (deliveryAddress.city == null || deliveryAddress.city!.isEmpty) {
        deliveryAddress.city = address.subLocality;
      }
      //state
      deliveryAddress.state ??= address.adminArea;
      if (deliveryAddress.state == null || deliveryAddress.state!.isEmpty) {
        deliveryAddress.state = address.subAdminArea;
      }
      //country
      deliveryAddress.country ??= address.countryName;

      //break if all data is set
      if (deliveryAddress.address != null &&
          deliveryAddress.city != null &&
          deliveryAddress.state != null &&
          deliveryAddress.country != null) {
        break;
      }
    }
    //
    // deliveryAddress.city = addresses.first.locality;
    // deliveryAddress.state = addresses.first.adminArea;
    // deliveryAddress.country = addresses.first.countryName;
    return deliveryAddress;
  }

  addToCartDirectly(Product product, int qty, {bool force = false}) async {
    //
    if (qty <= 0) {
      //
      final mProductsInCart = CartServices.productsInCart;
      final previousProductIndex = mProductsInCart.indexWhere(
        (e) => e.product?.id == product.id,
      );
      //
      if (previousProductIndex >= 0) {
        mProductsInCart.removeAt(previousProductIndex);
        await CartServices.saveCartItems(mProductsInCart);
      }
      return;
    }
    //
    final cart = Cart();
    cart.price = (product.showDiscount ? product.discountPrice : product.price);
    product.selectedQty = qty;
    cart.product = product;
    cart.selectedQty = product.selectedQty;
    cart.options = product.selectedOptions ?? [];
    cart.optionsIds = product.selectedOptions!.map((e) => e.id).toList();

    //

    try {
      //
      bool canAddToCart = await CartUIServices.handleCartEntry(
        viewContext,
        cart,
        product,
      );

      if (canAddToCart || force) {
        //
        final mProductsInCart = CartServices.productsInCart;
        final previousProductIndex = mProductsInCart.indexWhere(
          (e) => e.product?.id == product.id,
        );
        //
        if (previousProductIndex >= 0) {
          mProductsInCart.removeAt(previousProductIndex);
          mProductsInCart.insert(previousProductIndex, cart);
          await CartServices.saveCartItems(mProductsInCart);
        } else {
          await CartServices.addToCart(cart);
        }
      } else if (product.isDigital) {
        //
        AlertService.confirm(
          title: "Digital Product".tr(),
          text:
              "You can only buy/purchase digital products together with other digital products. Do you want to clear cart and add this product?"
                  .tr(),
          onConfirm: () async {
            await CartServices.clearCart();
            addToCartDirectly(product, qty, force: true);
          },
        );
      } else {
        //
        AlertService.confirm(
          title: "Different Vendor".tr(),
          text:
              "Are you sure you'd like to change vendors? Your current items in cart will be lost."
                  .tr(),
          onConfirm: () async {
            await CartServices.clearCart();
            addToCartDirectly(product, qty, force: true);
          },
        );
      }
    } catch (error) {
      print("Cart Error => $error");
      setError(error);
    }
  }

  //switch to use current location instead of selected delivery address
  void useUserLocation() {
    LocationService.geocodeCurrentLocation();
  }

  //
  openSearch({int showType = 4}) async {
    // final search = Search(
    //   vendorType: vendorType,
    //   showProductsTag: Search.showProductByShowType(showType),
    //   showServicesTag: Search.showServiceByShowType(showType),
    //   showProvidesTag: Search.showProvidersByShowType(showType),
    //   showVendorsTag: Search.showVendorByShowType(showType),
    //
    //   // showType:showType,
    // );
    // final page = NavigationService().searchPageWidget(search);
    // viewContext.nextPage(page);
  }


  //
  //
  productSelected(Product product) async {
    Navigator.pushNamed(viewContext, AppRoutes.product, arguments: product);
  }


  //show toast
  toastSuccessful(String msg) {
    ToastService.toastSuccessful(msg);
  }

  toastError(String msg, ) {
    ToastService.toastError(msg);
  }

  Future<void> fetchCurrentLocation() async {
    //
    Position currentLocation = await Geolocator.getCurrentPosition();
    //
    final address = await LocationService.addressFromCoordinates(
      lat: currentLocation.latitude,
      lng: currentLocation.longitude,
    );
    //
    LocationService.currenctAddress = address;
    if (address != null) {
      LocationService.currenctAddressSubject.sink.add(address);
    }
    deliveryaddress ??= DeliveryAddress();
    deliveryaddress!.address = address?.addressLine;
    deliveryaddress!.latitude = address?.coordinates?.latitude;
    deliveryaddress!.longitude = address?.coordinates?.longitude;
    deliveryaddress!.name = "Current Location".tr();
    LocationService.deliveryaddress = deliveryaddress;
    LocationService.currenctDeliveryAddressSubject.add(deliveryaddress!);
  }

  //handle fetch delivery address
  preloadDeliveryLocation() async {
    try {
      //fetch saved location from local storage
      deliveryaddress = LocationService.deliveryaddress;
      if (deliveryaddress == null) {
        deliveryaddress = await LocationService.getLocallySaveAddress();
      }
      notifyListeners();
    } catch (error) {
      print("Error getting delivery address => $error");
    }
  }

  // NEW LOCATION PICKER
  Future<dynamic> newPlacePicker() async {
    //
    LatLng initialPosition = LatLng(0.00, 0.00);
    double initialZoom = 0;
    if (LocationService.currenctAddress != null) {
      initialPosition = LatLng(
        LocationService.currenctAddress?.coordinates?.latitude ?? 0.00,
        LocationService.currenctAddress?.coordinates?.longitude ?? 0.00,
      );
      initialZoom = 15;
    }
    String? mapRegion;
    try {
      mapRegion = await Utils.getCurrentCountryCode();
    } catch (error) {
      print("Error getting sim country code => $error");
    }
    mapRegion ??= AppStrings.countryCode
        .trim()
        .split(",")
        .firstWhere(
          (e) => !e.toLowerCase().contains("auto"),
          orElse: () {
            return "";
          },
        );


    //google maps
    return await Navigator.push(
      viewContext,
      MaterialPageRoute(
        builder:
            (context) => MapLocationPicker(
              geoCodingConfig: GeoCodingConfig(apiKey: AppStrings.googleMapApiKey,
                // language: AppService().navigatorKey.currentContext!.languageCode,
                language: translator.activeLocale.languageCode,

              ),
              searchConfig: SearchConfig(
                baseRegion: mapRegion,


                 onSelected: (p0) {
                   Navigator.of(context).pop(p0);

                 },
                suggestionsOrigin: Location(
                  lat: initialPosition.latitude,
                  lng: initialPosition.longitude,
                ),
              ),
              config: MapLocationPickerConfig(apiKey: AppStrings.googleMapApiKey,

              ),

            ),
      ),
    );
  }

}
