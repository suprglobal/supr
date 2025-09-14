import 'dart:convert';

class OfferModel {
  final bool? success;
  final Data? data;
  final String? message;

  OfferModel({
    this.success,
    this.data,
    this.message,
  });

  factory OfferModel.fromRawJson(String str) => OfferModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
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
  final List<OfferRecord>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
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
    data: json["data"] == null ? [] : List<OfferRecord>.from(json["data"]!.map((x) => OfferRecord.fromJson(x))),
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

class OfferRecord {
  final int? id;
  final int? restaurantId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? bannerType;
  final int? position;
  final bool? isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? linkUrl;
  final bool? targetBlank;
  final int? sortOrder;
  final int? clickCount;
  final int? impressionCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final Restaurant? restaurant;

  OfferRecord({
    this.id,
    this.restaurantId,
    this.title,
    this.description,
    this.imageUrl,
    this.bannerType,
    this.position,
    this.isActive,
    this.startDate,
    this.endDate,
    this.linkUrl,
    this.targetBlank,
    this.sortOrder,
    this.clickCount,
    this.impressionCount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.restaurant,
  });

  factory OfferRecord.fromRawJson(String str) => OfferRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferRecord.fromJson(Map<String, dynamic> json) => OfferRecord(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["image_url"],
    bannerType: json["banner_type"],
    position: json["position"],
    isActive: json["is_active"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    linkUrl: json["link_url"],
    targetBlank: json["target_blank"],
    sortOrder: json["sort_order"],
    clickCount: json["click_count"],
    impressionCount: json["impression_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "title": title,
    "description": description,
    "image_url": imageUrl,
    "banner_type": bannerType,
    "position": position,
    "is_active": isActive,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "link_url": linkUrl,
    "target_blank": targetBlank,
    "sort_order": sortOrder,
    "click_count": clickCount,
    "impression_count": impressionCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "restaurant": restaurant?.toJson(),
  };
}

class Restaurant {
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
  };
}

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
