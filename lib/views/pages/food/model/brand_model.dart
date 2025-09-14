import 'dart:convert';

class BrandModel {
  final bool? status;
  final String? message;
  final List<BrandDetailRecord>? data;

  BrandModel({
    this.status,
    this.message,
    this.data,
  });

  factory BrandModel.fromRawJson(String str) => BrandModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<BrandDetailRecord>.from(json["data"]!.map((x) => BrandDetailRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BrandDetailRecord {
  final int? id;
  final String? name;
  final String? description;
  final dynamic logoUrl;
  final dynamic bannerUrl;
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
  final dynamic openingHours;
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
  final dynamic assignedAdminId;
  final int? assignedManagerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic logoUrlFormatted;
  final dynamic bannerUrlFormatted;
  final String? fullAddress;
  final bool? isOpen;
  final String? deliveryTimeRange;
  final bool? canUserManage;

  BrandDetailRecord({
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

  factory BrandDetailRecord.fromRawJson(String str) => BrandDetailRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandDetailRecord.fromJson(Map<String, dynamic> json) => BrandDetailRecord(
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
