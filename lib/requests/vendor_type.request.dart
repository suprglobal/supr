import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/services/http.service.dart';
import 'package:superapp/services/location.service.dart';

class VendorTypeRequest extends HttpService {
  //
  Future<List<VendorType>> index() async {
    print("LocationService.cLat: ${LocationService.cLat}");
    // final params = {
    //   "latitude": await LocationService.getFetchByLocationLat(),
    //   "longitude": await LocationService.getFetchByLocationLng(),
    // };
    print("params: ");
    final apiResult = await get(
      Api.vendorTypes,
      // queryParameters: params,
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return (apiResponse.body as List)
          .map((e) => VendorType.fromJson(e))
          .toList();
    }

    throw apiResponse.message!;
  }
}
