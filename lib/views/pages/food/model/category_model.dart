import 'dart:convert';

class CategoryModel {
  final bool? success;
  final Data? data;
  final String? message;

  CategoryModel({
    this.success,
    this.data,
    this.message,
  });

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int? currentPage;
  final List<CategoryRecord>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<CategoryRecord>.from(json["data"]!.map((x) => CategoryRecord.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CategoryRecord {
  final int? id;
  final int? restaurantId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? iconUrl;
  final int? sortOrder;
  final bool? isActive;
  final bool? isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? imageUrlFormatted;
  final String? iconUrlFormatted;
  final int? productCount;
  final Restaurant? restaurant;
  final List<CategoryRecord>? subcategories;
  final int? categoryId;

  CategoryRecord({
    this.id,
    this.restaurantId,
    this.name,
    this.description,
    this.imageUrl,
    this.iconUrl,
    this.sortOrder,
    this.isActive,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageUrlFormatted,
    this.iconUrlFormatted,
    this.productCount,
    this.restaurant,
    this.subcategories,
    this.categoryId,
  });

  factory CategoryRecord.fromRawJson(String str) => CategoryRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryRecord.fromJson(Map<String, dynamic> json) => CategoryRecord(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    iconUrl: json["icon_url"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isFeatured: json["is_featured"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    imageUrlFormatted: json["image_url_formatted"],
    iconUrlFormatted: json["icon_url_formatted"],
    productCount: json["product_count"],
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
    subcategories: json["subcategories"] == null ? [] : List<CategoryRecord>.from(json["subcategories"]!.map((x) => CategoryRecord.fromJson(x))),
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "icon_url": iconUrl,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_featured": isFeatured,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "image_url_formatted": imageUrlFormatted,
    "icon_url_formatted": iconUrlFormatted,
    "product_count": productCount,
    "restaurant": restaurant?.toJson(),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "category_id": categoryId,
  };
}

class Restaurant {
  final int? id;
  final Name? name;
  final String? description;
  final String? logoUrl;
  final String? bannerUrl;
  final CuisineType? cuisineType;
  final Address? address;
  final City? city;
  final State? state;
  final Country? country;
  final String? postalCode;
  final String? latitude;
  final String? longitude;
  final Phone? phone;
  final Email? email;
  final String? website;
  final String? openingHours;
  final String? deliveryFee;
  final String? minimumOrder;
  final int? minDeliveryTime;
  final int? maxDeliveryTime;
  final bool? deliveryAvailable;
  final bool? pickupAvailable;
  final String? deliveryRadius;
  final Status? status;
  final bool? isFeatured;
  final bool? isVerified;
  final String? rating;
  final int? totalReviews;
  final String? assignedAdminId;
  final int? assignedManagerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? logoUrlFormatted;
  final String? bannerUrlFormatted;
  final FullAddress? fullAddress;
  final bool? isOpen;
  final DeliveryTimeRange? deliveryTimeRange;
  final bool? canUserManage;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.bannerUrl,
    this.cuisineType,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.phone,
    this.email,
    this.website,
    this.openingHours,
    this.deliveryFee,
    this.minimumOrder,
    this.minDeliveryTime,
    this.maxDeliveryTime,
    this.deliveryAvailable,
    this.pickupAvailable,
    this.deliveryRadius,
    this.status,
    this.isFeatured,
    this.isVerified,
    this.rating,
    this.totalReviews,
    this.assignedAdminId,
    this.assignedManagerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.logoUrlFormatted,
    this.bannerUrlFormatted,
    this.fullAddress,
    this.isOpen,
    this.deliveryTimeRange,
    this.canUserManage,
  });

  factory Restaurant.fromRawJson(String str) => Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    description: json["description"],
    logoUrl: json["logo_url"],
    bannerUrl: json["banner_url"],
    cuisineType: cuisineTypeValues.map[json["cuisine_type"]]!,
    address: addressValues.map[json["address"]]!,
    city: cityValues.map[json["city"]]!,
    state: stateValues.map[json["state"]]!,
    country: countryValues.map[json["country"]]!,
    postalCode: json["postal_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    phone: phoneValues.map[json["phone"]]!,
    email: emailValues.map[json["email"]]!,
    website: json["website"],
    openingHours: json["opening_hours"],
    deliveryFee: json["delivery_fee"],
    minimumOrder: json["minimum_order"],
    minDeliveryTime: json["min_delivery_time"],
    maxDeliveryTime: json["max_delivery_time"],
    deliveryAvailable: json["delivery_available"],
    pickupAvailable: json["pickup_available"],
    deliveryRadius: json["delivery_radius"],
    status: statusValues.map[json["status"]]!,
    isFeatured: json["is_featured"],
    isVerified: json["is_verified"],
    rating: json["rating"],
    totalReviews: json["total_reviews"],
    assignedAdminId: json["assigned_admin_id"],
    assignedManagerId: json["assigned_manager_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    logoUrlFormatted: json["logo_url_formatted"],
    bannerUrlFormatted: json["banner_url_formatted"],
    fullAddress: fullAddressValues.map[json["full_address"]]!,
    isOpen: json["is_open"],
    deliveryTimeRange: deliveryTimeRangeValues.map[json["delivery_time_range"]]!,
    canUserManage: json["can_user_manage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "description": description,
    "logo_url": logoUrl,
    "banner_url": bannerUrl,
    "cuisine_type": cuisineTypeValues.reverse[cuisineType],
    "address": addressValues.reverse[address],
    "city": cityValues.reverse[city],
    "state": stateValues.reverse[state],
    "country": countryValues.reverse[country],
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "phone": phoneValues.reverse[phone],
    "email": emailValues.reverse[email],
    "website": website,
    "opening_hours": openingHours,
    "delivery_fee": deliveryFee,
    "minimum_order": minimumOrder,
    "min_delivery_time": minDeliveryTime,
    "max_delivery_time": maxDeliveryTime,
    "delivery_available": deliveryAvailable,
    "pickup_available": pickupAvailable,
    "delivery_radius": deliveryRadius,
    "status": statusValues.reverse[status],
    "is_featured": isFeatured,
    "is_verified": isVerified,
    "rating": rating,
    "total_reviews": totalReviews,
    "assigned_admin_id": assignedAdminId,
    "assigned_manager_id": assignedManagerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "logo_url_formatted": logoUrlFormatted,
    "banner_url_formatted": bannerUrlFormatted,
    "full_address": fullAddressValues.reverse[fullAddress],
    "is_open": isOpen,
    "delivery_time_range": deliveryTimeRangeValues.reverse[deliveryTimeRange],
    "can_user_manage": canUserManage,
  };
}

enum Address {
  THE_123_MAIN_STREET,
  THE_456_OAK_AVENUE,
  THE_789_PINE_STREET
}

final addressValues = EnumValues({
  "123 Main Street": Address.THE_123_MAIN_STREET,
  "456 Oak Avenue": Address.THE_456_OAK_AVENUE,
  "789 Pine Street": Address.THE_789_PINE_STREET
});

enum City {
  CHICAGO,
  LOS_ANGELES,
  NEW_YORK
}

final cityValues = EnumValues({
  "Chicago": City.CHICAGO,
  "Los Angeles": City.LOS_ANGELES,
  "New York": City.NEW_YORK
});

enum Country {
  USA
}

final countryValues = EnumValues({
  "USA": Country.USA
});

enum CuisineType {
  AMERICAN,
  ITALIAN,
  JAPANESE
}

final cuisineTypeValues = EnumValues({
  "American": CuisineType.AMERICAN,
  "Italian": CuisineType.ITALIAN,
  "Japanese": CuisineType.JAPANESE
});

enum DeliveryTimeRange {
  THE_2035_MIN,
  THE_2545_MIN,
  THE_3050_MIN
}

final deliveryTimeRangeValues = EnumValues({
  "20-35 min": DeliveryTimeRange.THE_2035_MIN,
  "25-45 min": DeliveryTimeRange.THE_2545_MIN,
  "30-50 min": DeliveryTimeRange.THE_3050_MIN
});

enum Email {
  INFO_BURGERHOUSE_COM,
  INFO_PIZZAPALACE_COM,
  INFO_SUSHIEXPRESS_COM
}

final emailValues = EnumValues({
  "info@burgerhouse.com": Email.INFO_BURGERHOUSE_COM,
  "info@pizzapalace.com": Email.INFO_PIZZAPALACE_COM,
  "info@sushiexpress.com": Email.INFO_SUSHIEXPRESS_COM
});

enum FullAddress {
  THE_123_MAIN_STREET_NEW_YORK_NY_USA_10001,
  THE_456_OAK_AVENUE_LOS_ANGELES_CA_USA_90210,
  THE_789_PINE_STREET_CHICAGO_IL_USA_60601
}

final fullAddressValues = EnumValues({
  "123 Main Street, New York, NY, USA, 10001": FullAddress.THE_123_MAIN_STREET_NEW_YORK_NY_USA_10001,
  "456 Oak Avenue, Los Angeles, CA, USA, 90210": FullAddress.THE_456_OAK_AVENUE_LOS_ANGELES_CA_USA_90210,
  "789 Pine Street, Chicago, IL, USA, 60601": FullAddress.THE_789_PINE_STREET_CHICAGO_IL_USA_60601
});

enum Name {
  BURGER_HOUSE,
  PIZZA_PALACE,
  SUSHI_EXPRESS
}

final nameValues = EnumValues({
  "Burger House": Name.BURGER_HOUSE,
  "Pizza Palace": Name.PIZZA_PALACE,
  "Sushi Express": Name.SUSHI_EXPRESS
});

enum Phone {
  THE_15550123,
  THE_15550456,
  THE_15550789
}

final phoneValues = EnumValues({
  "+1-555-0123": Phone.THE_15550123,
  "+1-555-0456": Phone.THE_15550456,
  "+1-555-0789": Phone.THE_15550789
});

enum State {
  CA,
  IL,
  NY
}

final stateValues = EnumValues({
  "CA": State.CA,
  "IL": State.IL,
  "NY": State.NY
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
