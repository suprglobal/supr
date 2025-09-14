import 'dart:developer';

import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/models/driver.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/models/tax_order_location.history.dart';
import 'package:superapp/models/vehicle.dart';
import 'package:superapp/models/vehicle_type.dart';
import 'package:superapp/services/http.service.dart';

class TaxiRequest extends HttpService {
  //
  Future<List<VehicleType>> getVehicleTypes() async {
    final apiResult = await get("${Api.vehicleTypes}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return (apiResponse.body as List)
          .map((object) => VehicleType.fromJson(object))
          .toList();
    } else {
      throw apiResponse.message!;
    }
  }

  //
  Future<List<VehicleType>> getVehicleTypePricing(
    DeliveryAddress pickup,
    DeliveryAddress dropoff,
      String type,
      {
    String? countryCode,
  }) async {
    //
    log("pickup ${pickup.longitude}");
    log("dropoff ${dropoff.longitude}");
    log("countryCode $countryCode");
    log("type $type");

    final apiResult = await get(
      "${Api.vehicleTypePricing}",
      queryParameters: {
        "pickup": "${pickup.latitude},${pickup.longitude}",
        "dropoff": "${dropoff.latitude},${dropoff.longitude}",
        "country_code": "$countryCode",
        "type":type
      },
    );
    print("TETETE ${{
      "pickup": "${pickup.latitude},${pickup.longitude}",
      "dropoff": "${dropoff.latitude},${dropoff.longitude}",
      "country_code": "$countryCode",
      "type": "$type",
    }}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {

      print('bchxbvbcxnvb  ${apiResponse.body }');
      List<VehicleType> vehicleTypes = [];
      (apiResponse.body as List).forEach(
        (object) {
          //
          try {
            final vehicleType = VehicleType.fromJson(object);
            vehicleTypes.add(vehicleType);
          } catch (e) {
            print(e);
          }
        },
      );

      return vehicleTypes;
    } else {
      throw apiResponse.message!;
    }
  }

  Future<ApiResponse> locationAvailable(
    double latitude,
    double longitude,
  ) async {
    final apiResult = await get(
      Api.taxiLocationAvailable,
      queryParameters: {
        "latitude": latitude,
        "longitude": longitude,
      },
    );
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> placeNeworder({
    Map<String, dynamic>? params,
  }) async {
    log("message  ${params}");
    final apiResult = await post(
      "${Api.newTaxiBooking}",
      params,
    );
    log("respone -->${apiResult.data}");
    return ApiResponse.fromResponse(apiResult);
  }

  Future<Order?> getOnGoingTrip() async {
    final apiResult = await get(
      "${Api. currentTaxiBooking}",
    );
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    //
    if (apiResponse.allGood) {
      //if there is order
      if (apiResponse.body["order"] != null) {
        return Order.fromJson(apiResponse.body["order"]);
      } else {
        return null;
      }
    }

    //
    throw apiResponse.body;
  }

  //
  Future<ApiResponse> cancelTrip(int id) async {
    final apiResult = await get(
      "${Api.cancelTaxiBooking}/$id",
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<Driver> getDriverInfo(int id) async {
    final apiResult = await get(
      "${Api.taxiDriverInfo}/$id",
    );
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    final driver = Driver.fromJson(apiResponse.body["driver"]);
    driver.vehicle = Vehicle.fromJson(apiResponse.body["vehicle"]);
    return driver;
  }

  Future<ApiResponse> rateDriver(
    int orderId,
    int driverId,
    double newTripRating,
    String review,
  ) async {
    //
    final apiResult = await post(
      "${Api.rating}",
      {
        //
        "driver_id": driverId,
        "order_id": orderId,
        "rating": newTripRating,
        "review": review,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  Future<List<TaxiOrderLocationHistory>> locationHistory() async {
    final apiResult = await get(Api.taxiTripLocationHistory);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    return (apiResponse.body as List)
        .map((e) => TaxiOrderLocationHistory.fromJson(e))
        .toList();
  }

  Future<Order?> getLastTripForRating() async {
    final apiResult = await get(Api.lastRatebleTaxiBooking);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      if (apiResponse.body["order"] != null) {
        return Order.fromJson(apiResponse.body["order"]);
      } else {
        return null;
      }
    }
    throw apiResponse.body;
  }
}
