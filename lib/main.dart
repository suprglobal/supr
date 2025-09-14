import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart';
import 'services/firebase.service.dart';
import 'package:superapp/firebase_options.dart';
import 'package:superapp/my_app.dart';
import 'package:superapp/services/cart.service.dart';
import 'package:superapp/services/general_app.service.dart';
import 'package:superapp/services/local_storage.service.dart';
 import 'package:superapp/services/notification.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'constants/app_languages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

/// Background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    name: "'ride-e341a'",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GeneralAppService.onBackgroundMessageHandler(message);
}

Future<void> main() async {
  // ✅ Must be first


  runZonedGuarded(() async {
    await WidgetsFlutterBinding.ensureInitialized();

    // SSL override (dev only)
    HttpOverrides.global = MyHttpOverrides();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // 👈 background color
        statusBarIconBrightness: Brightness.dark, // 👈 icon color
      ),
    );
    await Firebase.initializeApp(
      name: "'ride-e341a'",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Localization
    // await LocalizeAndTranslate.init(
    //   supportedLanguageCodes: ['en'],
    //   defaultType: LocalizationDefaultType.asDefined,
    //   assetLoader: AssetLoaderRootBundleJson('assets/lang/'),
    // );

    await translator.init(
      localeType: LocalizationDefaultType.asDefined,
      languagesList: AppLanguages.codes,
      assetsDirectory: 'assets/lang/',
    );
    // Firebase Auth language
    FirebaseAuth.instance.setLanguageCode('en');


    // Load local storage & cart
    await LocalStorageService.getPrefs();
    await CartServices.getCartItems();

    // Notifications setup
    await NotificationService.clearIrrelevantNotificationChannels();
    await NotificationService.initializeAwesomeNotification();
    await NotificationService.listenToActions();

    // Firebase Messaging
    await FirebaseService().setUpFirebaseMessaging();

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Crashlytics setup
    FlutterError.onError = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    runApp(LocalizedApp(child: MyApp()));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });
}
