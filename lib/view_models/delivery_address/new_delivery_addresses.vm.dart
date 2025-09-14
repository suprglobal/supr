import 'package:flutter/material.dart';
import 'package:superapp/models/address.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/requests/delivery_address.request.dart';
import 'package:superapp/services/alert.service.dart';
import 'package:superapp/view_models/delivery_address/base_delivery_addresses.vm.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:superapp/extensions/context.dart';
import 'package:map_location_picker/map_location_picker.dart';

class NewDeliveryAddressesViewModel extends BaseDeliveryAddressesViewModel {
  //
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController what3wordsTEC = TextEditingController();
  bool isDefault = false;
  DeliveryAddress? deliveryAddress = new DeliveryAddress();

  //
  NewDeliveryAddressesViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  showAddressLocationPicker() async {
    dynamic result = await newPlacePicker();

    if (result is GeocodingResult) {
      GeocodingResult locationResult = result;
      addressTEC.text = locationResult.formattedAddress ?? "";
      deliveryAddress!.address = locationResult.formattedAddress;
      deliveryAddress!.latitude = locationResult.geometry.location.lat;
      deliveryAddress!.longitude = locationResult.geometry.location.lng;

      if (locationResult.addressComponents.isNotEmpty) {
        //fetch city, state and country from address components
        locationResult.addressComponents.forEach((addressComponent) {
          if (addressComponent.types.contains("locality")) {
            deliveryAddress!.city = addressComponent.longName;
          }
          if (addressComponent.types.contains("administrative_area_level_1")) {
            deliveryAddress!.state = addressComponent.longName;
          }
          if (addressComponent.types.contains("country")) {
            deliveryAddress!.country = addressComponent.longName;
          }
        });
      } else {
        // From coordinates
        setBusy(true);
        deliveryAddress = await getLocationCityName(deliveryAddress!);
        setBusy(false);
      }
      notifyListeners();
    } else if (result is Address) {
      Address locationResult = result;
      addressTEC.text = locationResult.addressLine ?? "";
      deliveryAddress!.address = locationResult.addressLine;
      deliveryAddress!.latitude = locationResult.coordinates?.latitude;
      deliveryAddress!.longitude = locationResult.coordinates?.longitude;
      deliveryAddress!.city = locationResult.locality;
      deliveryAddress!.state = locationResult.adminArea;
      deliveryAddress!.country = locationResult.countryName;
    }
  }

  //

  void toggleDefault(bool? value) {
    isDefault = value ?? false;
    deliveryAddress!.isDefault = isDefault ? 1 : 0;
    notifyListeners();
  }

  //
  saveNewDeliveryAddress() async {
    if (formKey.currentState!.validate()) {
      //
      deliveryAddress!.name = nameTEC.text;
      deliveryAddress!.description = descriptionTEC.text;
      //
      setBusy(true);
      //
      final apiRespose = await deliveryAddressRequest.saveDeliveryAddress(
        deliveryAddress!,
      );

      //
      AlertService.dynamic(
        type: apiRespose.allGood ? AlertType.success : AlertType.error,
        title: "New Delivery Address".tr(),
        text: apiRespose.message,
        onConfirm: () {
          viewContext.pop(true);
        },
      );
      //
      setBusy(false);
    }
  }

  //
}
