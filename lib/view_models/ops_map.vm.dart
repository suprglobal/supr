import 'dart:async';
import 'package:flutter/material.dart';
import 'package:superapp/services/geocoder.service.dart';
import 'package:superapp/view_models/base.view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:superapp/extensions/context.dart';

class OPSMapViewModel extends MyBaseViewModel {
  //
  OPSMapViewModel(BuildContext context) {
    this.viewContext = context;
  }

  Address? selectedAddress;
  GeocoderService geocoderService = GeocoderService();
  TextEditingController searchTEC = TextEditingController();
  EdgeInsets googleMapPadding = EdgeInsets.all(10);
  GoogleMapController? gMapController;
  Timer? _debounce;
  Map<MarkerId, Marker> gMarkers = <MarkerId, Marker>{};
  Marker? centerMarker;
  MarkerId centerMarkerId = MarkerId('center_loc_marker');

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<Address>> fetchPlaces(String keyword) async {
    return await geocoderService.findAddressesFromQuery(keyword);
  }

  Future<Address> fetchPlaceDetails(Address address) async {
    return await geocoderService.fecthPlaceDetails(address);
  }

  onMapCreated(controller) {
    gMapController = controller;
    notifyListeners();
  }

  addressSelected(Address address, {bool moveCamera = true}) async {
    setBusyForObject(selectedAddress, true);
    selectedAddress = address;
    //fecth place details from google if its google map
    if (address.gMapPlaceId != null) {
      selectedAddress = await geocoderService.fecthPlaceDetails(address);
    }

    //
    searchTEC.clear();
    if (moveCamera) {
      if (address.coordinates != null || selectedAddress?.coordinates != null) {
        double lat = address.coordinates?.latitude ??
            selectedAddress?.coordinates?.latitude ??
            0.0;
        double lng = address.coordinates?.longitude ??
            selectedAddress?.coordinates?.longitude ??
            0.0;
        gMapController?.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 16,
              target: LatLng(
                lat,
                lng,
              ),
            ),
          ),
        );
      }
    }
    setBusyForObject(selectedAddress, false);
  }

  updateMapPadding(Size size) {
    googleMapPadding = EdgeInsets.only(bottom: size.height + 10);
  }

  mapCameraMove(CameraPosition position) async {
    if (centerMarker == null) {
      centerMarker = Marker(
        markerId: centerMarkerId,
        position: position.target,
        draggable: true,
      );
    } else {
      centerMarker = centerMarker?.copyWith(
        positionParam: position.target,
      );
    }

    //
    gMarkers[centerMarkerId] = centerMarker!;
    notifyListeners();

    //
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      // do something with query
      selectedAddress = null;
      setBusyForObject(selectedAddress, true);
      try {
        final address = (await geocoderService.findAddressesFromCoordinates(
          Coordinates(
            position.target.latitude,
            position.target.longitude,
          ),
        ))
            .first;

        addressSelected(address, moveCamera: false);
      } catch (error) {
        toastError("$error");
      }
      setBusyForObject(selectedAddress, false);
      _debounce?.cancel();
    });
  }

  submit() {
    viewContext.pop(selectedAddress);
  }
}
