// import 'package:velocity_x/velocity_x.dart';

import 'package:superapp/services/auth.service.dart';

class Api {
  static String get baseUrl {
    // return "https://blueviolet-sheep-340272.hostingersite.com";
    // return "https://khaki-chamois-968656.hostingersite.com/api";
    return 'https://multisevices.in/api';
    // return 'https://ride.multisevices.in/api';
    // return "http://192.168.100.3:8000/api";
  }

  static const appSettings = "/app/settings";
  static const appOnboardings = "/app/onboarding?type=customer";
  static const faqs = "/app/faqs?type=customer";

  static const accountDelete = "/account/delete";
  static const tokenSync = "/device/token/sync";
  static const login = "/login";
  static const qrlogin = "/login/qrcode";
  static const register = "/register";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";
  static const verifyPhoneAccount = "/verify/phone";
  static const updateProfile = "/profile/update";
  static const updatePassword = "/profile/password/update";

  //
  static const sendOtp = "/otp/send";
  static const verifyOtp = "/otp/verify";
  static const verifyFirebaseOtp = "/otp/firebase/verify";
  static const socialLogin = "/social/login";

  //
  static const banners = "/banners";
  static const categories = "/categories";
  static const products = "/products";
  static const services = "/services";
  static const bestProducts = "/products?type=best";
  static const forYouProducts = "/products?type=you";
  static const vendorTypes = "/vendor/types";
  static const vendors = "/vendors";
  static const vendorReviews = "/vendor/reviews";
  static const topVendors = "/vendors?type=top";
  static const bestVendors = "/vendors?type=best";

  static const search = "/search";
  static const tags = "/tags";
  static const searchData = "/search/data";
  static const favourites = "/favourites";
  static const favouriteVendors = "/favourite/vendors";

  //cart & checkout
  static const coupons = "/coupons";
  static const deliveryAddresses = "/delivery/addresses";
  static const paymentMethods = "/payment/methods";
  static const orders = "/orders";
  static const trackOrder = "/track/order";
  static const packageOrders = "/package/orders";
  static const packageOrderSummary = "/package/order/summary";
  static const generalOrderDeliveryFeeSummary =
      "/general/order/delivery/fee/summary";
  static const generalOrderSummary = "/general/order/summary";
  static const serviceOrderSummary = "/service/order/summary";
  static const chat = "/chat/notification";
  static const rating = "/rating";

  //packages
  static const packageTypes = "/package/types";
  static const packageVendors = "/package/order/vendors";

  //Taxi booking
  static const vehicleTypes = "/vehicle/types";
  static const vehicleTypePricing = "/vehicle/types/pricing";
  static const newTaxiBooking = "/taxi/book/order";
  static const currentTaxiBooking = "/taxi/current/order";
  static const lastRatebleTaxiBooking = "/taxi/rateable/order";
  static const cancelTaxiBooking = "/taxi/order/cancel";
  static const taxiDriverInfo = "/taxi/driver/info";
  static const taxiLocationAvailable = "/taxi/location/available";
  static const taxiTripLocationHistory = "/taxi/location/history";

  //wallet
  static const walletBalance = "/wallet/balance";
  static const walletTopUp = "/wallet/topup";
  static const walletTransactions = "/wallet/transactions";
  static const myWalletAddress = "/wallet/my/address";
  static const walletAddressesSearch = "/wallet/address/search";
  static const walletTransfer = "/wallet/address/transfer";

  //loyaltypoints
  static const myLoyaltyPoints = "/loyalty/point/my";
  static const loyaltyPointsWithdraw = "/loyalty/point/my/withdraw";
  static const loyaltyPointsReport = "/loyalty/point/my/report";

  //map
  static const geocoderForward = "/geocoder/forward";
  static const geocoderReserve = "/geocoder/2/reserve";
  static const geocoderPlaceDetails = "/geocoder/place/details";

  //reviews
  static const productReviewSummary = "/product/review/summary";
  static const productReviews = "/product/reviews";
  static const productBoughtFrequent = "/product/frequent";

  //flash sales
  static const flashSales = "/flash/sales";
  static const externalRedirect = "/external/redirect";

  //
  static const cancellationReasons = "/cancellation/reasons";

  // Other pages
  static String get privacyPolicy {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/privacy/policy";
  }

  static String get terms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/terms";
  }

  static String get paymentTerms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/payment/terms";
  }

  static String get refundTerms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/refund/terms";
  }

  static String get cancelTerms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/cancel/terms";
  }

  static String get shippingTerms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/shipping/terms";
  }

  static String get contactUs {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/contact";
  }

  static String get inappSupport {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/support/chat";
  }

  static String get appShareLink {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/preview/share";
  }

  static Future<String> redirectAuth({String? url, String? route}) async {
    final userToken = await AuthServices.getAuthBearerToken();
    final webUrl = "$baseUrl/external/web/redirect";
    return "$webUrl?token=$userToken&route=$route&url=$url";
  }



  /// food
  static const String trendingRestaurants ="/restaurants/trending";
  static const String searchFoodApi ="/all-search?query=";
  static const String filterFoodApi ="/filter";
  static const String allCategories ="/restaurant-categories";
  static const String bestSellerRestaurants ="/restaurants/best-sellers";
  static const String nearbyRestaurants ="/restaurants/nearby?latitude=40.7505&longitude=-73.9934";
  static const String restaurantDetail ="/restaurants";
  static const String productDetail ="/restaurant-products";
  static const String popularBrands ="/restaurants/popular-brands";
  static const String allRestaurants ="/restaurants?latitude=40.7505&longitude=-73.9934&radius=5&delivery_available=true";
  static const String restaurantBanners ="/restaurant-banners";
}
