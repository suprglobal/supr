import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:get/get.dart';
import 'package:superapp/constants/app_theme.dart';
import 'package:superapp/services/app.service.dart';
import 'package:superapp/views/pages/auth/provider/auth_provider.dart';
import 'package:superapp/views/pages/auth/provider/name_input_provider.dart';
import 'package:superapp/views/pages/auth/provider/otp_provider.dart';
import 'package:superapp/views/pages/auth/provider/phone_input_provider.dart';
import 'package:superapp/views/pages/dine_out/controller/dine_out_provider.dart';
import 'package:superapp/views/pages/dine_out/controller/filter_color_provider.dart';
import 'package:superapp/views/pages/dine_out/controller/filter_controller.dart';
import 'package:superapp/views/pages/dine_out/controller/offer_controller.dart';
import 'package:superapp/views/pages/dine_out/controller/state_controller.dart';
import 'package:superapp/views/pages/dine_out/provider/faqs_provider.dart';
import 'package:superapp/views/pages/dine_out/provider/filter_provider.dart';
import 'package:superapp/views/pages/dine_out/provider/view_toggler_provider.dart';
import 'package:superapp/views/pages/food/controller/cart_controller.dart';
import 'package:superapp/views/pages/food/controller/food_controller.dart';
import 'package:superapp/views/pages/food/provider/drink_selection_provider.dart';
import 'package:superapp/views/pages/food/provider/selection_toggle_provider.dart';
import 'package:superapp/views/pages/profiles/controller/bank_controller.dart';
import 'package:superapp/views/pages/profiles/controller/date_provider.dart';
import 'package:superapp/views/pages/profiles/controller/gender_controller.dart';
import 'package:superapp/views/pages/profiles/controller/language_controller.dart';
import 'package:superapp/views/pages/profiles/controller/profile_controller.dart';
import 'package:superapp/views/pages/splash.page.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'constants/app_strings.dart';
import 'package:superapp/services/router.service.dart' as router;
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhoneInputProvider()),
        ChangeNotifierProvider(create: (_) => OTPProvider()..startTimer()),
        ChangeNotifierProvider<ProfileController>(
            create: (_) => ProfileController()),
        ChangeNotifierProvider<LanguageController>(
            create: (_) => LanguageController()),
        ChangeNotifierProvider<BankProvider>(create: (_) => BankProvider()),
        ChangeNotifierProvider<GenderProvider>(create: (_) => GenderProvider()),
        ChangeNotifierProvider<DateProvider>(create: (_) => DateProvider()),
        ChangeNotifierProvider<DineOutProvider>(
            create: (_) => DineOutProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => FAQProvider()),
        ChangeNotifierProvider(create: (_) => FilterProviders()),
        ChangeNotifierProvider(create: (_) => DineOutProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
        ChangeNotifierProvider<AppBarProvider>(create: (_) => AppBarProvider()),
        ChangeNotifierProvider(create: (_) => ViewToggleProvider()),

        ChangeNotifierProvider<OfferProvider>(create: (_) => OfferProvider()),
        ChangeNotifierProvider<FoodController>(
          create: (_) => FoodController(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodToggleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DrinkSelectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryFilterProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => NameInputProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProviders(),
        ),

      ],

      child: AdaptiveTheme(
        light: AppTheme().lightTheme(),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return GetMaterialApp(
            navigatorKey: AppService().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            onGenerateRoute: router.generateRoute,
            onUnknownRoute: (RouteSettings settings) {
              // open your app when is executed from outside when is terminated.
              return router.generateRoute(settings);
            },
            builder: (context, child) {
              // child = LocalizeAndTranslate.directionBuilder(context, child);

              return Stack(
              children: [child!, DropdownAlert()],
            );
            },


            // initialRoute: _sartRoute,
            localizationsDelegates: translator.delegates,
            locale: translator.activeLocale,
            supportedLocales: translator.locals(),
            home: SplashPage(),
            theme: theme,
            // darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
