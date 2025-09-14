import 'dart:convert';

class AllRestaurantsModel {
  final bool? success;
  final Data? data;
  final String? message;

  AllRestaurantsModel({
    this.success,
    this.data,
    this.message,
  });

  factory AllRestaurantsModel.fromRawJson(String str) => AllRestaurantsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllRestaurantsModel.fromJson(Map<String, dynamic> json) => AllRestaurantsModel(
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
  final List<RestaurantsModel>? data;
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
    data: json["data"] == null ? [] : List<RestaurantsModel>.from(json["data"]!.map((x) => RestaurantsModel.fromJson(x))),
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

class RestaurantsModel {
  final int? id;
  final String? name;
  final String? description;
  final String? logoUrl;
  final String? bannerUrl;
  final String? cuisineType;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? latitude;
  final String? longitude;
  final String? phone;
  final String? email;
  final String? website;
  final String? openingHours;
  final String? deliveryFee;
  final String? minimumOrder;
  final int? minDeliveryTime;
  final int? maxDeliveryTime;
  final bool? deliveryAvailable;
  final bool? pickupAvailable;
  final String? deliveryRadius;
  final String? status;
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
  final String? fullAddress;
  final bool? isOpen;
  final String? deliveryTimeRange;
  final bool? canUserManage;
  final List<Category>? categories;
  final List<Product>? products;

  RestaurantsModel({
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
    this.categories,
    this.products,
  });

  factory RestaurantsModel.fromRawJson(String str) => RestaurantsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) => RestaurantsModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    logoUrl: json["logo_url"],
    bannerUrl: json["banner_url"],
    cuisineType: json["cuisine_type"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postalCode: json["postal_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    phone: json["phone"],
    email: json["email"],
    website: json["website"],
    openingHours: json["opening_hours"],
    deliveryFee: json["delivery_fee"],
    minimumOrder: json["minimum_order"],
    minDeliveryTime: json["min_delivery_time"],
    maxDeliveryTime: json["max_delivery_time"],
    deliveryAvailable: json["delivery_available"],
    pickupAvailable: json["pickup_available"],
    deliveryRadius: json["delivery_radius"],
    status: json["status"],
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
    fullAddress: json["full_address"],
    isOpen: json["is_open"],
    deliveryTimeRange: json["delivery_time_range"],
    canUserManage: json["can_user_manage"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "logo_url": logoUrl,
    "banner_url": bannerUrl,
    "cuisine_type": cuisineType,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "phone": phone,
    "email": email,
    "website": website,
    "opening_hours": openingHours,
    "delivery_fee": deliveryFee,
    "minimum_order": minimumOrder,
    "min_delivery_time": minDeliveryTime,
    "max_delivery_time": maxDeliveryTime,
    "delivery_available": deliveryAvailable,
    "pickup_available": pickupAvailable,
    "delivery_radius": deliveryRadius,
    "status": status,
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
    "full_address": fullAddress,
    "is_open": isOpen,
    "delivery_time_range": deliveryTimeRange,
    "can_user_manage": canUserManage,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Category {
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

  Category({
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
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
  };
}

class Product {
  final int? id;
  final int? restaurantId;
  final int? categoryId;
  final int? subcategoryId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? price;
  final String? originalPrice;
  final String? discountPercentage;
  final String? discountAmount;
  final String? ingredients;
  final String? allergens;
  final int? preparationTime;
  final int? calories;
  final DietaryInfo? dietaryInfo;
  final bool? isAvailable;
  final bool? isFeatured;
  final bool? isPopular;
  final bool? isRecommended;
  final String? stockQuantity;
  final bool? trackStock;
  final bool? allowOutOfStockOrders;
  final bool? allowCustomization;
  final String? customizationOptions;
  final int? sortOrder;
  final int? viewCount;
  final int? orderCount;
  final String? rating;
  final int? totalReviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? imageUrlFormatted;
  final String? finalPrice;
  final String? discountPercentageCalculated;
  final bool? isInStock;
  final String? averageRatingFormatted;
  final RestaurantsModel? restaurant;



  Product({
    this.id,
    this.restaurantId,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.originalPrice,
    this.discountPercentage,
    this.discountAmount,
    this.ingredients,
    this.allergens,
    this.preparationTime,
    this.calories,
    this.dietaryInfo,
    this.isAvailable,
    this.isFeatured,
    this.isPopular,
    this.isRecommended,
    this.stockQuantity,
    this.trackStock,
    this.allowOutOfStockOrders,
    this.allowCustomization,
    this.customizationOptions,
    this.sortOrder,
    this.viewCount,
    this.orderCount,
    this.rating,
    this.totalReviews,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageUrlFormatted,
    this.finalPrice,
    this.discountPercentageCalculated,
    this.isInStock,
    this.averageRatingFormatted,
    this.restaurant
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    price: json["price"],
    originalPrice: json["original_price"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    ingredients: json["ingredients"],
    allergens: json["allergens"],
    preparationTime: json["preparation_time"],
    calories: json["calories"],
    dietaryInfo: dietaryInfoValues.map[json["dietary_info"]]!,
    isAvailable: json["is_available"],
    isFeatured: json["is_featured"],
    isPopular: json["is_popular"],
    isRecommended: json["is_recommended"],
    stockQuantity: json["stock_quantity"],
    trackStock: json["track_stock"],
    allowOutOfStockOrders: json["allow_out_of_stock_orders"],
    allowCustomization: json["allow_customization"],
    customizationOptions: json["customization_options"],
    sortOrder: json["sort_order"],
    viewCount: json["view_count"],
    orderCount: json["order_count"],
    rating: json["rating"],
    totalReviews: json["total_reviews"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    imageUrlFormatted: json["image_url_formatted"],
    finalPrice: json["final_price"],
    discountPercentageCalculated: json["discount_percentage_calculated"],
    isInStock: json["is_in_stock"],
    averageRatingFormatted: json["average_rating_formatted"],
    restaurant: json["restaurant"] == null ? null : RestaurantsModel.fromJson(json["restaurant"]),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "price": price,
    "original_price": originalPrice,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "ingredients": ingredients,
    "allergens": allergens,
    "preparation_time": preparationTime,
    "calories": calories,
    "dietary_info": dietaryInfoValues.reverse[dietaryInfo],
    "is_available": isAvailable,
    "is_featured": isFeatured,
    "is_popular": isPopular,
    "is_recommended": isRecommended,
    "stock_quantity": stockQuantity,
    "track_stock": trackStock,
    "allow_out_of_stock_orders": allowOutOfStockOrders,
    "allow_customization": allowCustomization,
    "customization_options": customizationOptions,
    "sort_order": sortOrder,
    "view_count": viewCount,
    "order_count": orderCount,
    "rating": rating,
    "total_reviews": totalReviews,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "image_url_formatted": imageUrlFormatted,
    "final_price": finalPrice,
    "discount_percentage_calculated": discountPercentageCalculated,
    "is_in_stock": isInStock,
    "average_rating_formatted": averageRatingFormatted,
    "restaurant": restaurant?.toJson(),

  };
}

enum DietaryInfo {
  CONTAINS_MEAT,
  CONTAINS_SEAFOOD,
  VEGAN_GLUTEN_FREE,
  VEGETARIAN
}

final dietaryInfoValues = EnumValues({
  "Contains meat": DietaryInfo.CONTAINS_MEAT,
  "Contains seafood": DietaryInfo.CONTAINS_SEAFOOD,
  "Vegan, Gluten-free": DietaryInfo.VEGAN_GLUTEN_FREE,
  "Vegetarian": DietaryInfo.VEGETARIAN
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
