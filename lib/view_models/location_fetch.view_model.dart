import 'dart:io';

import 'package:flutter/material.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/services/geocoder.service.dart';
import 'package:superapp/services/location.service.dart';
import 'package:superapp/services/permission.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:superapp/extensions/context.dart';

class LocationFetchViewModel extends MyBaseViewModel {
  LocationFetchViewModel(BuildContext context, this.nextPage) {
    this.viewContext = context;
  }

  bool showManuallySelection = false;
  bool showRequestPermission = false;
  Widget nextPage;
  //
  void initialise() async {
    try {
      //check for previous set location
      LocationService.deliveryaddress =
          await LocationService.getLocallySaveAddress();
    } catch (error) {
      print(error);
    }
    if (LocationService.deliveryaddress != null) {
      loadNextPage();
    } else {
      handleFetchCurrentLocation();
    }
  }

  handleFetchCurrentLocation() async {
    final granted = await locationPermissionGetter();
    showManuallySelection = !granted;
    showRequestPermission = granted;
    notifyListeners();
    if (granted) {
      await fetchCurrentLocation();
      if (LocationService.deliveryaddress != null) {
        loadNextPage();
      }
    }
  }

  Future<bool> locationPermissionGetter() async {
    bool granted = false;
    try {
      granted = await PermissionService.isLocationGranted();
      if (!granted) {
        final permanentlyDenied =
            await PermissionService.isLocationPermanentlyDenied();
        if (permanentlyDenied && !Platform.isIOS) {
          //
          toastError(
            "Permission is denied permanently, please re-enable permission from app info on your device settings. Thank you"
                .tr(),
          );
          //
          granted = await LocationService.showRequestDialog();
          if (granted) {
            granted = await Geolocator.openLocationSettings();
          }
        } else if (permanentlyDenied && Platform.isIOS) {
          //
          toastError(
            "Permission is denied permanently. You can skip the use for location and use the app manually. Thank you"
                .tr(),
          );
        } else {
          granted = await LocationService.showRequestDialog();

          if (granted) {
            try {
              granted = await PermissionService.requestPermission();
            } catch (error) {
              granted = false;
            }
          }
        }
      }
    } catch (error) {
      granted = false;
    }

    return granted;
  }

  void pickFromMap() async {
    //
    await locationPermissionGetter();

    dynamic result = await newPlacePicker();
    DeliveryAddress deliveryAddress = DeliveryAddress();

    if (result is GeocodingResult) {
      GeocodingResult locationResult = result;
      deliveryAddress.address = locationResult.formattedAddress;
      deliveryAddress.latitude = locationResult.geometry.location.lat;
      deliveryAddress.longitude = locationResult.geometry.location.lng;

      //
      if (locationResult.addressComponents.isNotEmpty) {
        //fetch city, state and country from address components
        locationResult.addressComponents.forEach((addressComponent) {
          if (addressComponent.types.contains("locality")) {
            deliveryAddress.city = addressComponent.longName;
          }
          if (addressComponent.types.contains("administrative_area_level_1")) {
            deliveryAddress.state = addressComponent.longName;
          }
          if (addressComponent.types.contains("country")) {
            deliveryAddress.country = addressComponent.longName;
          }
        });
        //get address from delivery address
        Address address = Address(
          featureName: deliveryAddress.name ?? deliveryAddress.address,
          addressLine: deliveryAddress.address,
          locality: deliveryAddress.city,
          adminArea: deliveryAddress.state,
          countryName: deliveryAddress.country,
          coordinates: Coordinates(
            deliveryAddress.latitude!,
            deliveryAddress.longitude!,
          ),
        );
        //
        LocationService.deliveryaddress = deliveryAddress;

        LocationService.currenctAddressSubject.add(address);
      } else {
        // From coordinates
        setBusy(true);
        final coordinates = new Coordinates(
          deliveryAddress.latitude!,
          deliveryAddress.longitude!,
        );
        //
        final addresses = await GeocoderService().findAddressesFromCoordinates(
          coordinates,
        );
        deliveryAddress.city = addresses.first.locality;
        setBusy(false);
        //
        LocationService.deliveryaddress = deliveryAddress;
        LocationService.currenctAddressSubject.add(addresses.first);
      }

      loadNextPage();
    } else if (result is Address) {
      Address locationResult = result;
      deliveryAddress.address = locationResult.addressLine;
      deliveryAddress.latitude = locationResult.coordinates?.latitude;
      deliveryAddress.longitude = locationResult.coordinates?.longitude;
      deliveryAddress.city = locationResult.locality;
      deliveryAddress.state = locationResult.adminArea;
      deliveryAddress.country = locationResult.countryName;
      //
      LocationService.deliveryaddress = deliveryAddress;
      LocationService.currenctAddressSubject.add(locationResult);
      loadNextPage();
    }
  }

  loadNextPage() async {
    try {
      await LocationService.saveSelectedAddressLocally(
        LocationService.deliveryaddress,
      );
      viewContext.pop();
      viewContext.nextAndRemoveUntilPage(nextPage);
    } catch (error) {
      print("error: $error");
    }
  }

  //
}
