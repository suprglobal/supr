import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:map_location_picker/map_location_picker.dart' hide Prediction, TravelMode;
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/models/vehicle_type.dart';
import 'package:superapp/services/geocoder.service.dart';
import 'package:superapp/services/location.service.dart';
import 'package:superapp/utils/map.utils.dart';
import 'package:superapp/view_models/checkout_base.vm.dart';
import 'package:superapp/views/pages/delivery_address/widgets/address_search.view.dart';

class TaxiGoogleMapViewModel extends CheckoutBaseViewModel {
  //
  int currentOrderStep = 1;
  int currentAddressSelectionStep = 1;
  bool onTrip = false;
  bool ignoreMapInteraction = false;

  //MAp related variables
  CameraPosition mapCameraPosition = CameraPosition(target: LatLng(0.00, 0.00));
  GoogleMapController? googleMapController;
  String? mapStyle;
  EdgeInsets googleMapPadding = EdgeInsets.all(10);
  StreamSubscription? currentLocationListener;
  // this will hold the generated polylines
  Set<Polyline> gMapPolylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  Set<Marker> gMapMarkers = {};
  PolylinePoints polylinePoints = PolylinePoints(
    apiKey: AppStrings.googleMapApiKey,
  );
  StreamSubscription? driverLocationStream;
  // for my custom icons
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  BitmapDescriptor? driverIcon;
  //END MAP RELATED VARIABLES

  //step 1
  TextEditingController placeSearchTEC = TextEditingController();
  TextEditingController pickupLocationTEC = TextEditingController();
  FocusNode pickupLocationFocusNode = FocusNode();
  DeliveryAddress? pickupLocation;
  TextEditingController dropoffLocationTEC = TextEditingController();
  FocusNode dropoffLocationFocusNode = FocusNode();
  DeliveryAddress? dropoffLocation;

  //
  dispose() {
    super.dispose();
    currentLocationListener?.cancel();
    pickupLocationFocusNode.dispose();
    dropoffLocationFocusNode.dispose();
  }



  bool pickupSelected = false; // Initially false → next move is pickup
  LatLng? pickupLatLng;
  LatLng? dropoffLatLng;
  void setupInitialPickup() async {

    print("initial setup ");
    Position currentLocation = await Geolocator.getCurrentPosition();

    pickupLatLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    pickupLocation = DeliveryAddress(
      latitude: pickupLatLng!.latitude,
      longitude: pickupLatLng!.longitude,
    );



    gMapMarkers.add(
      Marker(
        markerId: MarkerId("pickup"),
        position: pickupLatLng!,
        infoWindow: InfoWindow(title: "Pickup"),
        icon: sourceIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    // Move camera to pickup
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pickupLatLng!, zoom: 16),
      ),
    );

    notifyListeners();
  }
  bool isDropoffSetByUser = false;



  // Smooth marker movement
  void onCameraMove(CameraPosition position) {
    mapCameraPosition = position;
    LatLng newPos = position.target;

    if (lastMarkerPosition == null) {
      lastMarkerPosition = newPos;
      _updateMarker(newPos);
      return;
    }

    _animateMarker(lastMarkerPosition!, newPos, Duration(milliseconds: 300));
    lastMarkerPosition = newPos;
  }
  GoogleMapController? mapController;

  // final Set<Marker> gMapMarkers = {};
  LatLng? lastMarkerPosition;

  // Called when map is created

  void _updateMarker(LatLng pos) {
    gMapMarkers.clear();
    gMapMarkers.add(Marker(
      markerId: MarkerId("center_marker"),
      position: pos,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));
    notifyListeners();
  }

  void _animateMarker(LatLng start, LatLng end, Duration duration) {
    int frames = 30;
    int count = 0;

    Timer.periodic(Duration(milliseconds: duration.inMilliseconds ~/ frames),
            (timer) {
          count++;
          double t = count / frames;
          double lat = start.latitude + (end.latitude - start.latitude) * t;
          double lng = start.longitude + (end.longitude - start.longitude) * t;
          _updateMarker(LatLng(lat, lng));

          if (count >= frames) timer.cancel();
        });
  }

  void onCameraIdle() {
    print("Camera stopped at: ${mapCameraPosition.target.latitude}, ${mapCameraPosition.target.longitude}");
  }




  void setCurrentStep(int step) {
    print('step1adhusfgy  xbzshbvhxjbv ');
    print('step ---> $step');
    currentOrderStep = step;
    onTrip = false;
    notifyListeners();
  }

  //MAP RELATED FUNCTIONS
  void updateGoogleMapPadding({required double height}) {
    googleMapPadding = EdgeInsets.only(bottom: height - 20);
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();
    setGoogleMapStyle();
    //start listening to user current location
    startUserLocationListener();
    setSourceAndDestinationIcons();
    setupInitialPickup(); // <-- sets pickup at current location
     try {
      googleMapController = controller;
      notifyListeners();
      setGoogleMapStyle();
      startUserLocationListener();
      setSourceAndDestinationIcons();
      // Add debug print
      print('Map created successfully');
    } catch (e) {
      print('Error initializing map: $e');
    }
  }

  //
  void setGoogleMapStyle() async {
    mapStyle = await DefaultAssetBundle.of(
      viewContext,
    ).loadString('assets/json/google_map_style.json');
    //
    notifyListeners();
  }

  //
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      AppImages.pickupLocation,
    );
    //
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      AppImages.dropoffLocation,
    );
    //
    driverIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      AppImages.driverCar,
    );
  }

  //
  updateDriverIconDynamically(VehicleType vehicleType) async {
    Uint8List? iconByteData = await MapUtils.imageToUint8List(
      base64String: vehicleType.iconBase64,
      url: vehicleType.icon,
    );
    if (iconByteData != null) {
      driverIcon = await BitmapDescriptor.fromBytes(iconByteData);
    }
  }

  void startUserLocationListener() async {
    await LocationService.prepareLocationListener();

    currentLocationListener = LocationService.currenctAddressSubject.listen((currentAddress) {
      if (pickupLatLng == null) {
        // First-time setup: pickup marker
        pickupLatLng = LatLng(
          currentAddress.coordinates?.latitude ?? 0.0,
          currentAddress.coordinates?.longitude ?? 0.0,
        );

        pickupLocation = DeliveryAddress(
          address: "Pickup Location",
          latitude: pickupLatLng!.latitude,
          longitude: pickupLatLng!.longitude,
        );

        gMapMarkers.add(
          Marker(
            markerId: MarkerId("pickup"),
            position: pickupLatLng!,
            icon: sourceIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );

        // Move camera to pickup once at start
        googleMapController?.animateCamera(
          CameraUpdate.newLatLngZoom(pickupLatLng!, 16),
        );

        notifyListeners();
      } else {
        // Optional: smoothly update pickup position if driver moves
        LatLng newPos = LatLng(
          currentAddress.coordinates?.latitude ?? pickupLatLng!.latitude,
          currentAddress.coordinates?.longitude ?? pickupLatLng!.longitude,
        );

        // Only update if moved significant distance
        if ((pickupLatLng!.latitude - newPos.latitude).abs() > 0.0001 ||
            (pickupLatLng!.longitude - newPos.longitude).abs() > 0.0001) {
          pickupLatLng = newPos;
          gMapMarkers.removeWhere((m) => m.markerId.value == "pickup");
          gMapMarkers.add(
            Marker(
              markerId: MarkerId("pickup"),
              position: pickupLatLng!,
              icon: sourceIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
          );
          notifyListeners();
        }
      }
    });
  }

  //zoom to provided location
  void zoomToLocation(LatLng target, {double zoom = 16}) {
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
    notifyListeners();
  }

  openLocationSelector(int step, {bool showpicker = true}) async {
    /// open address picker
    if (showpicker) {
      await openLocationPicker();
    }
    // currentAddressSelectionStep = step;
    ///
    if (currentAddressSelectionStep == 1) {

      pickupLocation = checkout?.deliveryAddress;
      pickupLocationTEC.text = checkout?.deliveryAddress?.address ?? "";
    } else {
      dropoffLocation = checkout?.deliveryAddress;
      dropoffLocationTEC.text = checkout?.deliveryAddress?.address ?? "";
    }

    //
    notifyListeners();
  }

  //
  openLocationPicker() async {
    //
    deliveryAddress = DeliveryAddress();
    checkout?.deliveryAddress = null;
    //
    await showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return AddressSearchView(
          this,
          addressSelected: (dynamic prediction) async {
            if (prediction is Prediction) {
              deliveryAddress?.address = prediction.description;
              deliveryAddress?.latitude = prediction.lat?.toDoubleOrNull();
              deliveryAddress?.longitude = prediction.lng?.toDoubleOrNull();
              //
              checkout!.deliveryAddress = deliveryAddress;
              //
              setBusy(true);
              await getLocationCityName(deliveryAddress!);
              setBusy(false);
            } else if (prediction is Address) {
              deliveryAddress?.address = prediction.addressLine;
              deliveryAddress?.latitude = prediction.coordinates?.latitude;
              deliveryAddress?.longitude = prediction.coordinates?.longitude;
              deliveryAddress?.city = prediction.locality;
              deliveryAddress?.state = prediction.adminArea;
              deliveryAddress?.country = prediction.countryName;
              checkout!.deliveryAddress = deliveryAddress;
            }
          },
          selectOnMap: this.showDeliveryAddressPicker,
        );
      },
    );
  }

  //
  Future<DeliveryAddress> showDeliveryAddressPicker() async {
    //
    dynamic result = await newPlacePicker();

    if (result is GeocodingResult) {
      GeocodingResult locationResult = result;
      deliveryAddress = DeliveryAddress();
      deliveryAddress!.address = locationResult.formattedAddress;
      deliveryAddress!.latitude = locationResult.geometry.location.lat;
      deliveryAddress!.longitude = locationResult.geometry.location.lng;
      checkout!.deliveryAddress = deliveryAddress;

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
      openLocationSelector(currentAddressSelectionStep, showpicker: false);
    } else if (result is Address) {
      Address locationResult = result;
      deliveryAddress = DeliveryAddress();
      deliveryAddress?.address = locationResult.addressLine;
      deliveryAddress?.latitude = locationResult.coordinates?.latitude;
      deliveryAddress?.longitude = locationResult.coordinates?.longitude;
      deliveryAddress?.city = locationResult.locality;
      deliveryAddress?.state = locationResult.adminArea;
      deliveryAddress?.country = locationResult.countryName;
      checkout!.deliveryAddress = deliveryAddress;
      //
      openLocationSelector(currentAddressSelectionStep, showpicker: false);
    }
    //

    return deliveryAddress ?? DeliveryAddress();
  }



  Future<void> setupCurrentLocationAsPickuplocation() async {
    try {

      // Check location services
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("❌ Location services are disabled.");
        return;
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("❌ Location permissions are denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("❌ Location permissions are permanently denied.");
        return;
      }

      Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );



      List<Placemark> placemarks = await getAddressFromLatLng(currentLocation.latitude, currentLocation.longitude);



      if (placemarks.isNotEmpty) {

        Placemark place = placemarks.first;

        String fullAddress =
            "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        pickupLocation = DeliveryAddress(
          name: place.name ?? "Unknown",
          address: fullAddress,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );

      }
    } catch (e) {
      print("⚠️ Error getting location: $e");
    }
  }


  Future<List<Placemark>> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return [];

      final p = placemarks.first;
      // Build a friendly address — customize fields as you like
       return placemarks;
    } catch (e) {
      print("Reverse geocoding failed: $e");
      return [];
    }
  }


  drawTripPolyLines() async {
    if (pickupLocation == null || dropoffLocation == null) return;

    if (pickupLocation!.latitude == null ||
        pickupLocation!.longitude == null ||
        dropoffLocation!.latitude == null ||
        dropoffLocation!.longitude == null) return;

    // Clear previous data
    polylineCoordinates.clear();
    gMapPolylines.clear();

    // Add markers
    gMapMarkers = {
      Marker(
        markerId: MarkerId('pickup'),
        position: LatLng(pickupLocation!.latitude!, pickupLocation!.longitude!),
        // icon: sourceIcon!,
        icon: sourceIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "Pickup Location"),
        anchor: const Offset(0.5, 0.5),
      ),
      Marker(
        markerId: MarkerId('dropoff'),
        position: LatLng(dropoffLocation!.latitude!, dropoffLocation!.longitude!),
          icon: destinationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "Dropoff Location"),
        anchor: const Offset(0.5, 0.5),

      ),
    };

    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(
          pickupLocation!.latitude!,
          pickupLocation!.longitude!,
        ),
        destination: PointLatLng(
          dropoffLocation!.latitude!,
          dropoffLocation!.longitude!,
        ),
        mode: TravelMode.driving,
        /// apiKey: "YOUR_GOOGLE_API_KEY", // 👈 this is mandatory
      ),
    );




    if (polylineResult.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in polylineResult.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print("Polyline points empty. Check API key or Directions API enabled.");
    }

    // Add polyline
    gMapPolylines = {
      Polyline(
        polylineId: PolylineId("poly"),
        color: AppColors.primaryColor,
        points: polylineCoordinates,
        width: 4,
      )
    };

    // Zoom camera to bounds
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(pickupLocation!.latitude!, dropoffLocation!.latitude!),
        min(pickupLocation!.longitude!, dropoffLocation!.longitude!),
      ),
      northeast: LatLng(
        max(pickupLocation!.latitude!, dropoffLocation!.latitude!),
        max(pickupLocation!.longitude!, dropoffLocation!.longitude!),
      ),
    );

    googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));

    notifyListeners();
  }


  // --- Location pick logic ---
  void onLocationPicked(LatLng pos) async {

    final pickupIcon = await createMarkerWithLabel("Pickup", Colors.green);
    final dropoffIcon = await createMarkerWithLabel("Dropoff", Colors.red);
    if (pickupLatLng == null) {
      // First tap → Pickup
      pickupLatLng = pos;
      pickupLocation = DeliveryAddress(address: "Pickup Point", latitude: pos.latitude, longitude: pos.longitude);


      gMapMarkers.add(
        Marker(
          markerId: const MarkerId("pickup"),
          position: pos,
          infoWindow: const InfoWindow(title: "Pickup Location"),
          icon: pickupIcon,
          anchor: const Offset(0.5, 1.0),

        ),
      );
    } else if (dropoffLatLng == null) {
      // Second tap → Dropoff
      dropoffLatLng = pos;
      dropoffLocation = DeliveryAddress(address: "Dropoff Point", latitude: pos.latitude, longitude: pos.longitude);

      gMapMarkers.add(
        Marker(
          markerId:   MarkerId("dropoff"),
          position: pos,
          icon: dropoffIcon,
          anchor:   Offset(0.5, 1.0),
        ),
      );

      // Draw polyline
      await drawTripPolyLines();
    } else {
      // Third tap → Reset & start again
      gMapMarkers.clear();
      gMapPolylines.clear();
      polylineCoordinates.clear();

      pickupLatLng = pos;
      dropoffLatLng = null;
      pickupLocation = DeliveryAddress(address: "Pickup Point", latitude: pos.latitude, longitude: pos.longitude);

      gMapMarkers.add(
        Marker(
          markerId: const MarkerId("pickup"),
          position: pos,
          infoWindow: const InfoWindow(title: "Pickup Location"),
          icon: sourceIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
    notifyListeners();
  }
  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController? mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(source.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, source.longitude),
      );
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destination.latitude, source.longitude),
        northeast: LatLng(source.latitude, destination.longitude),
      );
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
    CameraUpdate cameraUpdate,
    GoogleMapController? mapController,
  ) async {
    if (mapController == null) {
      return;
    }
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  zoomToCurrentLocation() async {
    Position? currentLocation = await Geolocator.getLastKnownPosition();
    if (currentLocation == null) {
      currentLocation = await Geolocator.getCurrentPosition();
    }

    //
    double lat = currentLocation.latitude;
    double lng = currentLocation.longitude;
    zoomToLocation(LatLng(lat, lng));
  }

  //
  clearMapData() {
    gMapMarkers.clear();
    gMapMarkers = {};
    polylineCoordinates.clear();
    gMapPolylines.clear();
    pickupLocationTEC.clear();
    dropoffLocationTEC.clear();
    notifyListeners();
    driverLocationStream?.cancel();
    //
    setupCurrentLocationAsPickuplocation();
  }
}

Future<BitmapDescriptor> createMarkerWithLabel(String label, Color dotColor) async {
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint()..color = dotColor;

  const double size = 120;
  const double dotRadius = 20;

  // Draw text
  TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();

  textPainter.paint(
    canvas,
    Offset(size / 2 - textPainter.width / 2, 10), // text at top
  );

  // Draw dot below text
  canvas.drawCircle(
    Offset(size / 2, size - dotRadius - 10),
    dotRadius.toDouble(),
    paint,
  );

  // Convert to image
  final img = await recorder.endRecording().toImage(size.toInt(), size.toInt());
  final data = await img.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
