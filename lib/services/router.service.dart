// import 'package:firestore_chat/firestore_chat.dart';
import 'package:flutter/material.dart';
import 'package:superapp/constants/app_routes.dart';
import 'package:superapp/models/delivery_address.dart';
import 'package:superapp/models/notification.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/views/pages/auth/forgot_password.page.dart';
import 'package:superapp/views/pages/auth/login.page.dart';
import 'package:superapp/views/pages/auth/register.page.dart';
import 'package:superapp/views/pages/delivery_address/delivery_addresses.page.dart';
import 'package:superapp/views/pages/delivery_address/edit_delivery_addresses.page.dart';
import 'package:superapp/views/pages/delivery_address/new_delivery_addresses.page.dart';
import 'package:superapp/views/pages/delivery_address/widgets/location_fetch.page.dart';
import 'package:superapp/views/pages/home/home.dart';
import 'package:superapp/views/pages/notification/notification_details.page.dart';
import 'package:superapp/views/pages/notification/notifications.page.dart';
import 'package:superapp/views/pages/onboarding.page.dart';
import 'package:superapp/views/pages/order/orders_details.page.dart';
import 'package:superapp/views/pages/order/orders_tracking.page.dart';
import 'package:superapp/views/pages/profile/change_password.page.dart';
import 'package:superapp/views/pages/profile/edit_profile.page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => OnboardingPage());

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());

    case AppRoutes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homeRoute, arguments: Map()),
        builder: (context) => LocationFetchPage(
          child: HomeScreen(),
          // child: HomePage(),
        ),
      );




    //order details page
    case AppRoutes.orderDetailsRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.orderDetailsRoute),
        builder: (context) => OrderDetailsPage(
          order: settings.arguments as Order,
        ),
      );
    //order tracking page
    case AppRoutes.orderTrackingRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.orderTrackingRoute),
        builder: (context) => OrderTrackingPage(
          order: settings.arguments as Order,
        ),
      );


    //
    case AppRoutes.editProfileRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.editProfileRoute),
        builder: (context) => EditProfilePage(),
      );

    //change password
    case AppRoutes.changePasswordRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.changePasswordRoute),
        builder: (context) => ChangePasswordPage(),
      );

    //Delivery addresses
    case AppRoutes.deliveryAddressesRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.deliveryAddressesRoute),
        builder: (context) => DeliveryAddressesPage(),
      );
    case AppRoutes.newDeliveryAddressesRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.newDeliveryAddressesRoute),
        builder: (context) => NewDeliveryAddressesPage(),
      );
    case AppRoutes.editDeliveryAddressesRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.editDeliveryAddressesRoute),
        builder: (context) => EditDeliveryAddressesPage(
          deliveryAddress: settings.arguments as DeliveryAddress,
        ),
      );


    //profile settings/actions
    case AppRoutes.notificationsRoute:
      return MaterialPageRoute(
        settings:
            RouteSettings(name: AppRoutes.notificationsRoute, arguments: Map()),
        builder: (context) => NotificationsPage(),
      );

    //
    case AppRoutes.notificationDetailsRoute:
      return MaterialPageRoute(
        settings: RouteSettings(
            name: AppRoutes.notificationDetailsRoute, arguments: Map()),
        builder: (context) => NotificationDetailsPage(
          notification: settings.arguments as NotificationModel,
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => OnboardingPage());
  }
}
