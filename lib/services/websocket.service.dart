import 'dart:convert';
import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:superapp/constants/api.dart';
import 'package:superapp/services/auth.service.dart';
import 'package:superapp/services/local_storage.service.dart';
import 'package:singleton/singleton.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as PUSHER;

class WebsocketService {
  //
  static String websocketServerSettingsKey = "WebsocketServerSettings";

  /// Factory method that reuse same instance automatically
  factory WebsocketService() => Singleton.lazy(() => WebsocketService._());

  /// Private constructor
  WebsocketService._() {}

  //
  Echo<PUSHER.PusherClient, PusherChannel>? echoClient;
  Channel? publicChannel;
  PrivateChannel? privateChannel;

  //
  init() async {
    if (echoClient != null) {
      return;
    }

    try {
      final userToken = await AuthServices.getAuthBearerToken();
      String authBaseUrl = Api.baseUrl.replaceAll('/api', '');
      log("authBaseUrl: $authBaseUrl");
      String wsHost = getWebsocketDetail("REVERB_HOST");
      String wsPort = getWebsocketDetail("REVERB_PORT");
      String wsAppKey = getWebsocketDetail("REVERB_APP_KEY");


      log("wsHost: $wsHost");
      log("wsPort: $wsPort");
      log("wssPort: $wsPort");
      log("authBaseUrl: $authBaseUrl");
      log("wsAppKey: $wsAppKey");
      log("userToken: $userToken");
      echoClient = Echo<PUSHER.PusherClient, PusherChannel>(

        PusherConnector(
          wsAppKey,
          authEndPoint: "$authBaseUrl/broadcasting/auth",
          authHeaders: {'Authorization': 'Bearer $userToken'},
          host: wsHost,
          wsPort: wsPort.toInt(),
          wssPort: wsPort.toInt(),
          encrypted: true,
          activityTimeout: 25000,
          pongTimeout: 30000,
          enableLogging: kDebugMode,
          autoConnect: true,
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  closeConnection() async {
    if (echoClient == null) {
      return;
    }

    //disconnect the cleint
    echoClient?.disconnect();
    echoClient = null;
  }

  //MISC.
  Future<bool> saveWebsocketDetails(
    Map<String, dynamic> websocketSettings,
  ) async {
    log("websocketSettings: $websocketSettings");
    return await LocalStorageService.prefs!.setString(
      websocketServerSettingsKey,
      jsonEncode(websocketSettings),
    );
  }


  String getWebsocketDetail(String key) {
    dynamic websocketSettings = LocalStorageService.prefs!.getString(
      websocketServerSettingsKey,
    );

    if (websocketSettings != null) {
      return jsonDecode(websocketSettings)[key] ?? "";
    }
    return "";
  }
}
