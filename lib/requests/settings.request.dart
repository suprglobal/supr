import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:superapp/constants/api.dart';
import 'package:superapp/models/api_response.dart';
import 'package:superapp/services/http.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SettingsRequest extends HttpService {
  //
  Future<ApiResponse> appSettings() async {
    try {
      final apiResult = await get(Api.appSettings);
      if(kDebugMode){
        log("apiResult ${apiResult.data}");
      }
      return ApiResponse.fromResponse(apiResult);
    } on DioError catch (error) {
      log("error $error");
      if (error.type == DioErrorType.unknown) {
        throw "Connection failed. Please check that your have internet connection on this device."
                .tr() +
            "\n" +
            "Try again later".tr();
      }
      throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<ApiResponse> appOnboardings() async {
    try {
      final apiResult = await get(Api.appOnboardings);
      return ApiResponse.fromResponse(apiResult);
    } on DioError catch (error) {
      if (error.type == DioErrorType.unknown) {
        throw "Connection failed. Please check that your have internet connection on this device."
                .tr() +
            "\n" +
            "Try again later".tr();
      }
      throw error;
    } catch (error) {
      throw error;
    }
  }
}
